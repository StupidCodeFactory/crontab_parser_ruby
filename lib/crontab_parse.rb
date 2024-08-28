# frozen_string_literal: true

require_relative "crontab_parse/version"

module CrontabParse
  class << self
    def parse(crontab_expression)
      {
        minutes: (0..59).to_a,
        hours: (0..23).to_a,
        day_of_month: (1..31).to_a,
        months: (1..12).to_a,
        day_of_week: (1..7).to_a
      }
    end
  end
end
