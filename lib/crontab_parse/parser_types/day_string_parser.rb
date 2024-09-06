
module CrontabParse
  class DayStringParser
    VALID_DAY_STRING = %w[MON TUE WED THU FRI SAT SUN].freeze
    def initialize(valid_range: )
      self.valid_range = valid_range
    end

    def parse(expression)

      match = expression
                .match(%r{(?<day>#{VALID_DAY_STRING.join("|")})(?:-((?<day_end_range>#{VALID_DAY_STRING.join("|")})))?$}i)

      self.day, self.day_end_range = match&.values_at(:day, :day_end_range)
      self.day = day.upcase rescue nil
      self.day_end_range = day_end_range.upcase rescue nil
      valid?
    end

    def to_a
      return [day_as_number(day)] if day_end_range.nil?

      (day_as_number(day)..day_as_number(day_end_range)).to_a
    end

    private

    attr_accessor :day, :day_end_range,  :valid_range

    def valid?
      is_valid_day = VALID_DAY_STRING.include?(self.day)
      return is_valid_day if day_end_range.nil?

      is_valid_day && VALID_DAY_STRING.include?(self.day_end_range)
    end

    def day_as_number(day_as_string)
      VALID_DAY_STRING.index(day_as_string) + 1
    end
  end
end
