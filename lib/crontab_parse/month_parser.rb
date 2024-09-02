# frozen_string_literal: true

require "crontab_parse/part_parser"
require "crontab_parse/month_string_parser"
require "crontab_parse/parser_error"

module CrontabParse
  class MonthParser < PartParser

    def initialize(valid_range: (1..12))
      super
    end

    def parse(expression)
      super do
        month_string_parser.to_a if month_string_parser.parse(expression)
      end
    end

    private

    def error_message(expression)
      "Invalid month value: [#{expression}]. Valid month values are integers between #{valid_range.begin} and #{valid_range.end}."
    end

    def month_string_parser
      @month_string_parser ||= MonthStringParser.new(valid_range: valid_range)
    end
  end
end
