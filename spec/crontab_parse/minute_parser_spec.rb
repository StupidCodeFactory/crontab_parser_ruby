require "spec_helper"
require "crontab_parse/minute_parser"

RSpec.describe CrontabParse::MinuteParser do
  describe ".parse_minutes" do
    context "when given a valid numerical minute" do
      "0".upto("59").each do |minute|
        it "parses #{minute}" do
          expect(subject.parse(minute)).to eq([minute.to_i])
        end
      end

      context "with a leading 0" do
        "00".upto("59").each do |minute|
          it "parses #{minute}" do
            expect(subject.parse(minute)).to eq([minute.to_i])
          end
        end
      end

      context "with , separated values" do
        it "parses a list of minutes" do
          expect(subject.parse("4,6,23,50")).to eq([4, 6, 23, 50])
        end

        context "when list value contains an out of bound value" do
          it "parses raises an error" do
            expect do
              subject.parse("4,6,60,50")
            end.to raise_error(
              CrontabParse::ParserError,
              "Invalid minute value: [4,6,60,50]. Valid minute values are integers between 0 and 59."
            )
          end
        end
      end

      context "with the wildcard *" do
        let(:minute) { "*" }

        it "parses the minute" do
          expect(subject.parse(minute)).to eq((0..59).to_a)
        end
      end

      context "with a ranges" do
        it "parses 10-58" do
          expect(subject.parse("10-58")).to eq((10..58).to_a)
        end

        it "parses 02-12" do
          expect(subject.parse("02-12")).to eq((2..12).to_a)
        end

        context "when range is out of bounds" do
          it "parses raises an error" do
            expect do
              subject.parse("10-60")
            end.to raise_error(
              CrontabParse::ParserError,
              "Invalid minute value: [10-60]. Valid minute values are integers between 0 and 59."
            )
          end
        end
      end
    end

    context "when given a invalid numerical minute" do
      let(:minute) { "-1" }

      it "raises an error" do
        expect { subject.parse(minute) }
          .to raise_error(
            CrontabParse::ParserError,
            "Invalid minute value: [#{minute}]. Valid minute values are integers between 0 and 59."
          )
      end
    end

    describe "stepped values" do
      let(:minute) { "*/15" }

      it "parses the minutes" do
        expect(subject.parse(minute)).to eq([0, 15, 30, 45])
      end
    end
  end
end
