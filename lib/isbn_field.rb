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
    
    # Calculate the sum for ISBN-10
    isbn.chars.each_with_index do |char, index|
      if index == 9 && char.upcase == 'X'
        sum += 10
      else
        sum += char.to_i * (10 - index)
      end
    end
    
    if sum % 11 == 0
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
      multiplier = index.even? ? 1 : 3
      sum += char.to_i * multiplier
    end
    
    if sum % 10 == 0
      [true, "validation pass"]
    else
      [false, "validation failed"]
    end
  end
end