require "spec_helper"

RSpec.describe CrontabParse::Parsers do
  describe '.parse_minutes' do
    specify do
      expect(described_class.parse_minute("*")).to eq((0..59).to_a)
    end
  end

  describe '.parse_hour' do
    specify do
      expect(described_class.parse_hour("*")).to eq((0..23).to_a)
    end
  end

  describe '.parse_day_of_month' do
    specify do
      expect(described_class.parse_day_of_month("*")).to eq((1..31).to_a)
    end
  end

  describe '.parse_month' do
    specify do
      expect(described_class.parse_month("*")).to eq((1..12).to_a)
    end
  end

  describe '.parse_day' do
    specify do
      expect(described_class.parse_day("*")).to eq((0..6).to_a)
    end
  end
end
