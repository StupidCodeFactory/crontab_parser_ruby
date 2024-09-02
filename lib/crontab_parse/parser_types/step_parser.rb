module CrontabParse
  class StepParser
    def initialize(valid_range)
      self.valid_range = valid_range
    end

    def parse(expression)
      self.step = expression.match(%r{^\*/(?<step>[0-5]?\d)$})&.values_at(:step)&.map(&:to_i)&.first
      self.step = Integer(step) rescue nil

      valid?
    end

    def to_a
      valid_range.step(step).to_a
    end

    private

    attr_accessor :step, :valid_range

    def valid?
      valid_range.include?(step)
    end
  end
end
