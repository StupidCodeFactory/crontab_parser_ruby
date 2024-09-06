# frozen_string_literal: true

RSpec.describe CrontabParse do

  describe ".parse_args" do
    let(:crontab) { '* * * * * /bin/echo "Hello, world!"' }

    context "when given no option" do
      let(:argv) { [crontab] }

      it "returns the crontab expression" do
        expect(described_class.parse_args(argv)).to eq(argv)
      end
    end

    context "when given and option" do
      let(:argv) { [crontab, "-c"] }

      it "returns the crontab and parsed arguments" do
        expect(described_class.parse_args(argv))
          .to eq([crontab, { optional: true }])
      end
    end
  end

  describe ".parse" do
    context "with a valid expresssion" do
      let(:crontab) { '* * * * * /bin/echo "Hello, world!"' }

      it "successfuly parses the crontab" do
        expect(described_class.parse(crontab))
          .to eq(
            minute: (0..59).to_a,
            hour: (0..23).to_a,
            day_of_month: (1..31).to_a,
            month: (1..12).to_a,
            day_of_week: (0..6).to_a,
            command: ['/bin/echo "Hello, world!"']
          )
      end

      context "when adding an optional flag" do
        let(:crontab) { '* * * * * /bin/echo "Hello, world!"' }

      end
    end

    context "with an invalid expresssion" do
      context "when the crontab does not have enough parts" do
        let(:crontab) { '* * * *' }

        specify do
          expect { described_class.parse(crontab) }.to raise_error ArgumentError, "invalid crontab expression: [#{crontab}]"
        end
      end

      context "when the crontab contains invalid part" do
        let(:crontab) { '*/60 * * * * /bin/echo "Hello, world!"' }

        specify do
          expect { described_class.parse(crontab) }.to raise_error CrontabParse::ParserError, "Invalid minute value: [*/60]. Valid minute values are integers between 0 and 59."
        end
      end
    end
  end
end
