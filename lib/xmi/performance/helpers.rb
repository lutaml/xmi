# frozen_string_literal: true

require "json"
require "open3"
require "tmpdir"
require "fileutils"

module Xmi
  module Performance
    # Shared helpers for the performance benchmark rake tasks.
    # Provides git/process helpers and the dual-namespace Runner loader
    # used by the comparison flow. Terminal formatting lives in
    # Xmi::Performance::Term; color codes on Xmi::Performance.
    module Helpers
      # Dual-namespace containers. The Runner class is cloned into
      # each so that Base and Current hold independent class objects
      # (preserving the shape of the comparison API even though both
      # currently resolve to the same benchmark code).
      module Base
      end

      module Current
      end

      class << self
        # Clone Xmi::Performance::Runner into the given namespace as
        # `::Runner`. Replaces the old module_eval-of-a-top-level-file
        # mechanism, which required require_relative and a top-level
        # class definition incompatible with autoload.
        def load_runner_into(namespace)
          Xmi::Performance::Runner # force autoload
          namespace.const_set(:Runner, Xmi::Performance::Runner.clone)
        end

        def ruby_exec(cmd, env: {})
          Open3.capture3(env, cmd)
        end

        def current_branch
          stdout, = ruby_exec("git rev-parse --abbrev-ref HEAD")
          stdout.strip
        end

        def run_benchmarks(base_runner, current_runner, threshold, all_base,
                           all_current)
          base_results = base_runner.run_benchmarks
          curr_results = current_runner.run_benchmarks

          all_base.merge!(base_results)
          all_current.merge!(curr_results)

          comparison_rows = []

          curr_results.each do |label, result|
            base_result = base_results[label]
            cmp = compare_metrics(label, result, base_result, threshold)
            comparison_rows << cmp
          end

          print_comparison_table(comparison_rows, threshold)
        end

        def print_comparison_table(comparison_rows, threshold)
          rows = comparison_rows.map do |cmp|
            {
              benchmark: cmp[:label],
              base_ips: cmp[:base_ips]&.round(1),
              curr_ips: cmp[:curr_ips]&.round(1),
              change: cmp[:change] ? "#{(cmp[:change] * 100).round(1)}%" : "N/A",
              status: if cmp[:base_ips].nil?
                        "NEW"
                      elsif cmp[:change] < -threshold
                        "REGRESSED"
                      else
                        "OK"
                      end,
            }
          end

          return if rows.empty?

          puts "  #{'Benchmark'.ljust(40)} #{'Base IPS'.rjust(12)} #{'Curr IPS'.rjust(12)} #{'Change'.rjust(10)} #{'Status'.rjust(10)}"
          puts "  #{DIM}#{'─' * 86}#{CLEAR}"

          rows.each do |row|
            status_color = case row[:status]
                           when "REGRESSED" then RED
                           when "NEW" then YELLOW
                           else GREEN
                           end

            puts "  #{row[:benchmark].ljust(40)} #{format('%-12.1f',
                                                          row[:base_ips] || 0)} #{format('%-12.1f',
                                                                                         row[:curr_ips] || 0)} #{format('%-10s', row[:change]).gsub('%',
                                                                                                                                                    '%%')} #{status_color}#{row[:status].rjust(10)}#{CLEAR}"
          end

          puts
        end

        def compare_metrics(label, curr, base, threshold)
          unless base
            return { label: label, base_ips: nil, curr_ips: nil, change: nil,
                     regressed: false }
          end

          base_ips = base.fetch(:lower)
          curr_ips = curr.fetch(:upper)
          change = (curr_ips - base_ips) / base_ips.to_f

          {
            label: label,
            base_ips: base_ips,
            curr_ips: curr_ips,
            change: change,
            regressed: change < -threshold,
          }
        end

        def summary_report(current_results, base_results, base, run_time, threshold)
          summary = {
            run_time: run_time,
            threshold: threshold,
            branch: current_branch,
            base: base,
            regressions: [],
            new_benchmarks: [],
          }

          current_results.each do |label, metrics|
            base_result = base_results[label]
            cmp = compare_metrics(label, metrics, base_result, threshold)

            if base_result.nil?
              summary[:new_benchmarks] << label
              next
            end

            next unless cmp[:regressed]

            summary[:regressions] << {
              label: label,
              base_ips: cmp[:base_ips],
              curr_ips: cmp[:curr_ips],
              delta_fraction: cmp[:change],
            }
          end

          log_regressions(summary[:regressions], threshold)
          log_new_benchmarks(summary[:new_benchmarks])
          summary
        end

        def log_new_benchmarks(new_benchmarks)
          return if new_benchmarks.empty?

          puts
          puts "#{YELLOW}🆕 New benchmarks (not in base branch):#{CLEAR}"
          new_benchmarks.each do |label|
            puts "  • #{label}"
          end
        end

        def log_regressions(regressions, threshold)
          return if regressions.empty?

          puts
          puts "#{RED}⚠️  Performance Regressions Detected#{CLEAR}"
          puts "#{RED}   (< -#{(threshold * 100).round(2)}% IPS)#{CLEAR}"
          puts
          regressions.each do |regression|
            delta = regression[:delta_fraction]
            base_ips = regression[:base_ips]
            curr_ips = regression[:curr_ips]

            delta_str = delta ? format("%+0.2f%%", delta * 100) : "N/A"
            base_str = base_ips ? format("%.2f", base_ips) : "N/A"
            curr_str = curr_ips ? format("%.2f", curr_ips) : "N/A"

            puts "  #{BOLD}#{regression[:label]}#{CLEAR}"
            puts "    #{GRAY}base: #{base_str} IPS#{CLEAR}"
            puts "    #{RED}curr: #{curr_str} IPS#{CLEAR}"
            puts "    #{RED}change: #{delta_str}#{CLEAR}"
            puts
          end
        end
      end
    end
  end
end
