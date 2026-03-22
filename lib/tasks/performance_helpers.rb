# frozen_string_literal: true

require "json"
require "open3"
require "tmpdir"
require "fileutils"

module PerformanceHelpers
  # ANSI color codes for terminal output
  CLEAR   = "\e[0m"
  BOLD    = "\e[1m"
  DIM     = "\e[2m"
  CYAN    = "\e[36m"
  GREEN   = "\e[32m"
  YELLOW  = "\e[33m"
  RED     = "\e[31m"
  GRAY    = "\e[90m"
  MAGENTA = "\e[35m"

  # Terminal formatting helpers
  module Term
    extend self

    HL = "─"
    VL = "│"
    TL = "┌"
    TR = "┐"
    BL = "└"
    BR = "┘"

    def header(title, color: PerformanceHelpers::CYAN)
      width = 78
      line = HL * width
      puts
      puts "#{color}#{TL}#{line}#{TR}#{CLEAR}"
      puts "#{color}#{VL}#{CLEAR}  #{BOLD}#{color}#{title}#{CLEAR}#{' ' * (width - title.length - 4)}#{color}#{VL}#{CLEAR}"
      puts "#{color}#{BL}#{line}#{BR}#{CLEAR}"
    end

    def sep(char: HL, width: 78)
      puts "#{DIM}#{char * width}#{CLEAR}"
    end
  end

  module Base
  end

  module Current
  end

  class << self
    def load_into_namespace(module_obj, file_path)
      content = File.read(file_path)
      module_obj.module_eval(content, file_path)
    end

    def ruby_exec(cmd, env: {})
      Open3.capture3(env, cmd)
    end

    def current_branch
      stdout, = ruby_exec("git rev-parse --abbrev-ref HEAD")
      stdout.strip
    end

    # Clone base branch into a temp dir and return its path
    def clone_base_repo(base, performance_dir, script)
      puts "#{DIM}Cloning base #{base}...#{CLEAR}"
      safe_ref = base.gsub(/[^0-9A-Za-z._-]/, "-")
      clone_dir = File.join(performance_dir, "base-#{safe_ref}")
      FileUtils.rm_rf(clone_dir)

      repo_url, = ruby_exec("git config --get remote.origin.url")
      repo_url = repo_url.strip

      stdout, stderr, status = ruby_exec("git clone --branch #{safe_ref} --single-branch #{repo_url} #{clone_dir}")
      raise "git clone failed: #{stderr}\n#{stdout}" unless status.success?

      Dir.chdir(clone_dir) do
        stdout, stderr, status = ruby_exec("bundle install --quiet")
        raise "bundle install failed: #{stderr}\n#{stdout}" unless status.success?

        bench_copy_dir = File.join(clone_dir, "lib", "tasks")
        FileUtils.mkdir_p(bench_copy_dir)
        bench_copy = File.join(bench_copy_dir, "benchmark_runner.rb")
        File.write(bench_copy, File.read(script))
        load_into_namespace(Base, bench_copy)
      end
    end

    def run_benchmarks(base_runner, current_runner, threshold, all_base,
                       all_current)
      base_results = base_runner.run_benchmarks
      curr_results = current_runner.run_benchmarks

      all_base.merge!(base_results)
      all_current.merge!(curr_results)

      # Collect comparison results
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
        row[:status] == "REGRESSED" ? RED : DIM

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

        # Track new benchmarks that don't exist in base
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
