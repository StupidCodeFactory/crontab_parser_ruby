require "crontab_parse/part_parser"
require "crontab_parse/parser_error"
require "crontab_parse/parser_types/day_string_parser"

module CrontabParse
  class DayParser < PartParser

    def initialize(valid_range: 0..6)
      super
    end

    def parse(expression)
      super do
        day_string_parser.to_a if day_string_parser.parse(expression)
      end
    end

    private

    def day_string_parser
      @day_string_parser ||= DayStringParser.new(valid_range: valid_range)
    end

    def error_message(expression)
      "Invalid day value: [#{expression}]. Valid day values are integers between #{valid_range.begin} and #{valid_range.end}."
    end
  end
end
