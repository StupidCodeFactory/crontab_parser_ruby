# frozen_string_literal: true

require "crontab_parse/part_parser"
require "crontab_parse/parser_error"

module CrontabParse
  class DayOfMonthParser < PartParser
    def initialize(valid_range: (1..31))
      super
    end

    private
    def error_message(expression)
      "Invalid day of month value: [#{expression}]. Valid day of month values are integers between 0 and 31."
    end
  end
end
