# frozen_string_literal: true

require_relative "crontab_parse/version"
require "crontab_parse/minute_parser"
require "crontab_parse/hour_parser"
require "crontab_parse/parsers"

module CrontabParse
  MINUTES_INDEX       = 0
  HOURS_INDEX         = 1
  DAYS_OF_MONTH_INDEX = 2
  MONTHS_INDEX        = 3
  DAYS_OF_WEEK_INDEX  = 4
  COMMAND_INDEX       = 5

  class << self
    def parse(crontab_expression)
      parts = crontab_expression.split(/ /)

      raise ArgumentError, "invalid crontab expression: [#{crontab_expression}]" unless parts.size > 5

      {
        minutes: Parsers.parse_minute(parts[MINUTES_INDEX]),
        hours: Parsers.parse_hour(parts[HOURS_INDEX]),
        days_of_month: Parsers.parse_day_of_month(parts[DAYS_OF_MONTH_INDEX]),
        months: Parsers.parse_month(parts[MONTHS_INDEX]),
        days_of_week: Parsers.parse_day(parts[DAYS_OF_WEEK_INDEX]),
        command: parts[COMMAND_INDEX..].join(" ")
      }
    end
  end
end
