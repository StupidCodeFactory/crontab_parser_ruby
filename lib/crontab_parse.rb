# frozen_string_literal: true

require_relative "crontab_parse/version"
require "crontab_parse/minute_parser"
require "crontab_parse/hour_parser"
require "crontab_parse/parsers"

module CrontabParse
  MINUTE_INDEX       = 0
  HOUR_INDEX         = 1
  DAY_OF_MONTH_INDEX = 2
  MONTH_INDEX        = 3
  DAY_OF_WEEK_INDEX  = 4
  COMMAND_INDEX      = 5

  class << self
    def parse(crontab_expression)
      parts = crontab_expression.split(/ /)

      raise ArgumentError, "invalid crontab expression: [#{crontab_expression}]" unless parts.size > 5

      {
        minute: Parsers.parse_minute(parts[MINUTE_INDEX]),
        hour: Parsers.parse_hour(parts[HOUR_INDEX]),
        day_of_month: Parsers.parse_day_of_month(parts[DAY_OF_MONTH_INDEX]),
        month: Parsers.parse_month(parts[MONTH_INDEX]),
        day_of_week: Parsers.parse_day(parts[DAY_OF_WEEK_INDEX]),
        command: [parts[COMMAND_INDEX..].join(" ")]
      }
    end
  end
end
