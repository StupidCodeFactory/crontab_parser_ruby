require "spec_helper"
pp require "crontab_parse/minute_parser"

RSpec.describe CrontabParse::Parsers do

  describe ".parse_minutes" do

    context "when given a valid numerical minute" do
      let(:minute) { rand(0..59).to_s }

      it "parses the minute" do
        expect(described_class.parse_minutes(minute)).to eq([minute.to_i])
      end

      context "allows for leading 0" do
        let(:minute) { "04" }

        it "parses the minute" do
          expect(described_class.parse_minutes(minute)).to eq([4])
        end
      end

      context "allows for *" do
        let(:minute) { "*" }

        it "parses the minute" do
          expect(described_class.parse_minutes(minute)).to eq((0..59).to_a)
        end
      end
    end

    context "when given a invalid numerical minute" do
      let(:minute) { "-1" }

      it "raises an error" do
        expect { described_class.parse_minutes(minute) }
          .to raise_error(
                CrontabParse::ParserError,
                "Invalid minute value: [#{minute}]. Valid minute values are integers between 0 and 59."
              )
      end
    end

    describe "stepped values" do
      let(:minute) { "*/15" }

      it "parses the minutes" do
        expect(described_class.parse_minutes(minute)).to eq([0, 15, 30, 45])
      end
    end
  end
end
