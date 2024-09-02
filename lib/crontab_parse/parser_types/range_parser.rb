module CrontabParse
  class RangeParser
    def initialize(valid_range)
      self.valid_range = valid_range
    end

    def parse(expression)
      self.lower_bound, self.upper_bound = expression
                                             .match(/(?<lower_bound>\d+)-(?<upper_bound>\d+)/)
                                             &.values_at(:lower_bound, :upper_bound)

      self.lower_bound = Integer(lower_bound) rescue nil
      self.upper_bound = Integer(upper_bound) rescue nil

      valid?
    end

    def to_a
      lower_bound.upto(upper_bound).to_a
    end

    private

    attr_accessor :lower_bound, :upper_bound, :valid_range

    def valid?
      valid_range.include?(lower_bound) && valid_range.include?(upper_bound) && lower_bound < upper_bound
    end
  end
end
