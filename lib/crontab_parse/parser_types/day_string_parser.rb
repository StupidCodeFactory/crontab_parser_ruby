
module CrontabParse
  class DayStringParser
    VALID_DAY_STRING = %w[MON TUE WED THU FRI SAT SUN].freeze
    def initialize(valid_range: )
      self.valid_range = valid_range
    end
    def parse(expression)
      self.day = expression
                     .match(%r{(?<day>#{VALID_DAY_STRING.join("|")})}i)
                     &.values_at(:day)
                     &.first
      self.day = self.day.upcase rescue nil
      valid?
    end

    def to_a
      [VALID_DAY_STRING.index(day) + 1]
    end

    private

    attr_accessor :day, :valid_range

    def valid?
      VALID_DAY_STRING.include?(self.day)
    end
  end
end
