require "spec_helper"

RSpec.describe CrontabParse::HourParser do
  # subject { CrontabParse.parse_ }

  describe "#parse" do
    context "when given a valid numerical hour" do
      "0".upto("23").each do |hour|
        it "parses the #{hour}" do
          expect(subject.parse(hour)).to eq([hour.to_i])
        end
      end

      context "with a leading 0" do
        "00".upto("23").each  do |hour|
          it "parses the #{hour}" do
            expect(subject.parse(hour)).to eq([hour.to_i])
          end
        end
      end

      context "with a ranges" do
        it "parses 02-12" do
          expect(subject.parse("02-12")).to eq((2..12).to_a)
        end

        context "when a value is out of bounds" do
          it "raises an error" do
            expect do
              subject.parse("25-24")
            end.to raise_error(
                     CrontabParse::ParserError,
                     "Invalid hour value: [25-24]. Valid hour values are integers between 0 and 23."
                   )
          end
        end
      end
    end

    context "with , separated values" do
      it "parses a list of hours" do
        expect(subject.parse("4,6,23")).to eq([4, 6, 23])
      end

      context "when list value contains an out of bound value" do
        it "parses raises an error" do
          expect do
            subject.parse("4,6,60,50")
          end.to raise_error(
                   CrontabParse::ParserError,
                   "Invalid hour value: [4,6,60,50]. Valid hour values are integers between 0 and 23."
                 )
        end
      end
    end

    context "when give a value greater than 23" do
      let(:hour) { "24" }

      it "raises an error" do
        expect { subject.parse(hour) }
          .to raise_error(
                CrontabParse::ParserError,
                "Invalid hour value: [#{hour}]. Valid hour values are integers between 0 and 23."
              )
      end
    end

    describe "stepped values" do
      let(:hour) { "*/8" }

      it "parses the hour" do
        expect(subject.parse(hour)).to eq([0, 8, 16])
      end
    end
  end
end
