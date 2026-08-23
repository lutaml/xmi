# frozen_string_literal: true

module Xmi
  module Performance
    # Terminal formatting for benchmark output. Colors live on the
    # parent Xmi::Performance module; box-drawing characters here.
    module Term
      extend self

      HL = "─"
      VL = "│"
      TL = "┌"
      TR = "┐"
      BL = "└"
      BR = "┘"

      def header(title, color: CYAN)
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

      def env_info(ruby_version, platform)
        puts
        puts "  #{DIM}Environment:#{CLEAR}"
        puts "  #{VL}  Ruby #{ruby_version} on #{platform}#{' ' * (60 - ruby_version.length - platform.length)}#{VL}"
        puts "  #{DIM}#{BL}#{HL * 76}#{BR}#{CLEAR}"
        puts
      end

      def category(title, icon:, description:, failure_means:,
compare_against: nil)
        puts
        puts "#{CYAN}#{VL}#{CLEAR}  #{BOLD}#{MAGENTA}#{icon} #{title}#{CLEAR}"
        puts
        puts "  #{DIM}#{description}#{CLEAR}"
        puts

        if compare_against
          puts "  #{CYAN}Comparing against:#{CLEAR} #{compare_against}"
          puts
        end

        puts "  #{YELLOW}⚠️  Failure means:#{CLEAR} #{failure_means}"
        puts
        sep(width: 76)
        puts
      end
    end
  end
end
