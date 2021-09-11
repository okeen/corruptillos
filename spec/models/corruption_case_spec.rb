require 'rails_helper'


RSpec.describe CorruptionCase, type: :model do
  fixtures(:corruption_cases)

  describe "valid?" do
    subject(:a_case) { corruption_cases("basic_case") }

    context "with valid attributes" do
      it "is valid" do
        expect(a_case).to be_valid
      end
    end

    %w[name stolen_amount place].each do |required_attr|
      context "with an empty #{required_attr}" do
        before do
          a_case[required_attr] = nil
        end

        it "is invalid" do
          expect(a_case).not_to be_valid
        end
      end
    end

    context "with a non unique name" do
      before do
        a_case.name = corruption_cases("guilty_case").name
      end

      it "is invalid" do
        expect(a_case).not_to be_valid
      end
    end

    context "with an lower than zero stolen_amount" do
      before do
        a_case.stolen_amount = -1
      end

      it "is invalid" do
        expect(a_case).not_to be_valid
      end
    end

    describe "sentence" do
      let(:valid_sentences) { [:innocent, :non_guilty, :guilty] }

      it "allows valid sentence values" do
        valid_sentences.each do |sentence|
          subject.sentence = sentence
          expect(subject).to be_valid
        end
      end
    end

    describe "save" do
      it "calls set_slug" do
        expect(subject).to receive(:set_slug)
        subject.save
      end
    end

    describe "set_slug" do
      before do
        subject.name = "Foo bar"
      end

      it "sets the slug attribute to the parameterized name" do
        subject.send(:set_slug)
        expect(subject.slug).to eq "foo-bar"
      end
    end
  end
end
