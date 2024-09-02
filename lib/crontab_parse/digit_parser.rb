module CrontabParse
  class DigitParser
    def initialize(valid_range)
      self.valid_range = valid_range
    end

    def parse(expression)
      begin
        self.digits = Integer(expression)
      rescue
        match = /^(\d+)$/.match(expression)
        self.digits = match[1].to_i if match
      end
      valid?
    end

    def to_a
      [digits]
    end

    private

    attr_accessor :valid_range, :digits

    def valid?
      valid_range.include?(digits)
    end
  end
end
