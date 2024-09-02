
module CrontabParse
  class MonthStringParser
    VALID_MONTH_STRING = %w[JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC].freeze
    def initialize(valid_range: )
      self.valid_range = valid_range
    end
    def parse(expression)
      self.month = expression
                     .match(%r{(?<month>#{VALID_MONTH_STRING.join("|")})}i)
                     &.values_at(:month)
                     &.first
      self.month = self.month.upcase rescue nil
      valid?
    end

    def to_a
      [VALID_MONTH_STRING.index(month) + 1]
    end

    private

    attr_accessor :month, :valid_range

    def valid?
      VALID_MONTH_STRING.include?(self.month)
    end
  end
end
