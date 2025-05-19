# frozen_string_literal: true

require_relative "isbn_field/version"

module IsbnField
  class Error < StandardError; end

  # Validates an ISBN-10 or ISBN-13 number
  # @param isbn [String] The ISBN number to validate
  # @return [Array<Boolean, String>] A tuple containing:
  #   - Boolean indicating if the ISBN is valid
  #   - String message describing the result
  def self.validate(isbn)
    return [false, "wrong format"] unless isbn.is_a?(String)

    # Remove any hyphens or spaces
    isbn_clean = isbn.gsub(/[\s-]/, '')

    # Check if the format is valid for either ISBN-10 or ISBN-13
    if isbn_clean.match?(/^\d{9}[\dX]$/)
      # ISBN-10 validation
      validate_isbn10(isbn_clean)
    elsif isbn_clean.match?(/^\d{13}$/)
      # ISBN-13 validation
      validate_isbn13(isbn_clean)
    else
      [false, "wrong format"]
    end
  end

  # Validates an ISBN-10 number
  # @param isbn [String] The cleaned ISBN-10 number to validate
  # @return [Array<Boolean, String>] Validation result and message
  def self.validate_isbn10(isbn)
    sum = 0

    # Calculate the sum for ISBN-10 (first 9 digits)
    9.times do |i|
      sum += isbn[i].to_i * (10 - i)
    end

    # Calculate the check digit
    check_digit = (11 - (sum % 11)) % 11

    # Compare with the actual check digit
    actual_check_digit = isbn[9].upcase == 'X' ? 10 : isbn[9].to_i

    if check_digit == actual_check_digit
      [true, "validation pass"]
    else
      [false, "validation failed"]
    end
  end

  # Validates an ISBN-13 number
  # @param isbn [String] The cleaned ISBN-13 number to validate
  # @return [Array<Boolean, String>] Validation result and message
  def self.validate_isbn13(isbn)
    sum = 0

    # Calculate the sum for ISBN-13
    isbn.chars.each_with_index do |char, index|
      # For ISBN-13, we alternate between weights of 1 and 3
      # The last digit is the check digit
      if index < 12
        multiplier = index.even? ? 1 : 3
        sum += char.to_i * multiplier
      end
    end

    # Calculate the check digit
    check_digit = (10 - (sum % 10)) % 10

    # Compare with the actual check digit
    if check_digit == isbn[12].to_i
      [true, "validation pass"]
    else
      [false, "validation failed"]
    end
  end
end
