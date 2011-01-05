require 'rspec/core/formatters/html_formatter'

module RSpec
  module Core
    module Formatters
      # Formats backtraces so they're clickable by TextMate
      class TextMateFormatter < HtmlFormatter
        def textmate_backtrace_line(line)
          if line = super(line)
            line.sub!(/([^:]*\.e?rb):(\d*)/) do
              "<a href=\"txmt://open?url=file://#{File.expand_path($1)}&line=#{$2}\">#{$1}:#{$2}</a> "
            end

            line
          end

          def format_backtrace(backtrace, example)
            return "" unless backtrace
            return backtrace if example.metadata[:full_backtrace] == true
            cleansed = backtrace.map { |line| textmate_backtrace_line(line) }.compact
            cleansed.empty? ? backtrace : cleansed
          end
        end
      end
    end
  end
end
