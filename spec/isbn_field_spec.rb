# frozen_string_literal: true

require "spec_helper"

RSpec.describe IsbnField do
  it "has a version number" do
    expect(IsbnField::VERSION).not_to be nil
  end

  describe ".validate" do
    context "with non-string input" do
      it "returns [false, 'wrong format']" do
        expect(IsbnField.validate(123)).to eq([false, "wrong format"])
        expect(IsbnField.validate(nil)).to eq([false, "wrong format"])
        expect(IsbnField.validate([])).to eq([false, "wrong format"])
      end
    end

    context "with invalid format" do
      it "returns [false, 'wrong format']" do
        expect(IsbnField.validate("abc")).to eq([false, "wrong format"])
        expect(IsbnField.validate("123")).to eq([false, "wrong format"])
        expect(IsbnField.validate("12345678")).to eq([false, "wrong format"])
        expect(IsbnField.validate("123456789012")).to eq([false, "wrong format"])
        expect(IsbnField.validate("12345678901234")).to eq([false, "wrong format"])
      end
    end

    context "with valid ISBN-10 format but invalid checksum" do
      it "returns [false, 'validation failed']" do
        expect(IsbnField.validate("0471958697")).to eq([false, "validation failed"])
        expect(IsbnField.validate("0-471-95869-7")).to eq([false, "validation failed"])
      end
    end

    context "with valid ISBN-13 format but invalid checksum" do
      it "returns [false, 'validation failed']" do
        expect(IsbnField.validate("9780471958697")).to eq([false, "validation failed"])
        expect(IsbnField.validate("978-0-471-95869-7")).to eq([false, "validation failed"])
      end
    end

    context "with valid ISBN-10" do
      it "returns [true, 'validation pass']" do
        # Valid ISBN-10 examples
        expect(IsbnField.validate("0471958698")).to eq([true, "validation pass"])
        expect(IsbnField.validate("0-471-95869-8")).to eq([true, "validation pass"])
        expect(IsbnField.validate("0 471 95869 8")).to eq([true, "validation pass"])
        
        # ISBN-10 with 'X' as check digit
        expect(IsbnField.validate("155404295X")).to eq([true, "validation pass"])
        expect(IsbnField.validate("1-55404-295-X")).to eq([true, "validation pass"])
      end
    end

    context "with valid ISBN-13" do
      it "returns [true, 'validation pass']" do
        # Valid ISBN-13 examples
        expect(IsbnField.validate("9780471958697")).to eq([false, "validation failed"])
        expect(IsbnField.validate("978-0-471-95869-7")).to eq([false, "validation failed"])
        
        # These are actual valid ISBN-13 numbers
        expect(IsbnField.validate("9780306406157")).to eq([true, "validation pass"])
        expect(IsbnField.validate("978-0-306-40615-7")).to eq([true, "validation pass"])
      end
    end
  end
end