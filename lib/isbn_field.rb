# frozen_string_literal: true

require_relative "isbn_field/version"

### Module: IsbnField
module IsbnField
  class Error < StandardError; end

  # Validates an ISBN number
  #
  # This method validates the format and check digit of a given ISBN number. It supports
  # validation for both ISBN-10 and ISBN-13 formats. The input string is sanitized to
  # remove hyphens and spaces before validation. The method then determines the type
  # of ISBN based on the cleaned input format and delegates validation to the respective
  # helper methods (`validate_isbn10` or `validate_isbn13`).
  #
  # ISBN-10 format: 9 digits followed by either a digit or 'X' (representing the value 10).
  # ISBN-13 format: 13 consecutive digits.
  #
  # If the input does not conform to either format or is not a string, the validation fails
  # with an appropriate error message.
  #
  # @param isbn [String] The raw ISBN number to validate (may contain hyphens or spaces)
  # @return [Array<Boolean, String>] Validation result and message:
  #   - Boolean indicating whether the ISBN is valid
  #   - String message describing the validation result ("validation pass" or "wrong format")
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
  #
  # This method validates the structure and check digit of a given ISBN-10 number.
  # It calculates the checksum based on the first nine digits, derives the check digit,
  # and compares it with the actual check digit provided in the input.
  #
  # The ISBN-10 check digit is calculated using modulo 11, with 'X' representing the
  # value of 10 in case the modulo operation results in a remainder of 10.
  #
  # @param isbn [String] The cleaned 10-character ISBN number to validate
  # @return [Array<Boolean, String>] Validation result and message:
  #   - Boolean indicating whether the ISBN-10 is valid
  #   - String message describing the result
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

  # Validates the structure and check digit of a given ISBN-13 number.
  #
  # This method performs validation of ISBN-13 by calculating the weighted sum
  # of the first 12 digits, deriving the check digit using modulo 10, and
  # comparing it with the actual check digit provided as the 13th digit.
  #
  # The weights alternate between 1 and 3 for each digit. The validation passes
  # only if the calculated check digit matches the given check digit.
  #
  # @param isbn [String] The cleaned 13-character ISBN number to validate
  # @return [Array<Boolean, String>] Validation result and message:
  #   - Boolean indicating whether the ISBN-13 is valid
  #   - String message describing the result
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
