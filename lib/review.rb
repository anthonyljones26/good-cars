# frozen_string_literal: true

require 'nokogiri'
# This class creates a review object from a review-entry section of an html doc
class Review
  attr_reader :score, :full_text, :stars

  def initialize(entry)
    if entry.is_a?(Nokogiri::XML::Element)
      # find all the review text in review entry
      title = entry.xpath(".//span[contains(@class, 'review-title')]").text
      text = entry.xpath(".//span[contains(@class, 'review-whole')]").text
      @full_text = title + text

      # retreive the review rating value from class
      @stars = retreive_rating_from_class(entry)
      @score = calc_score
    else
      @stars = 0
      @score = 0
      @full_text = ''
    end
  end

  def calc_score
    score = 0

    # count the '!'
    e_count = @full_text.count('!')

    words = filter_text(@full_text)

    # calculate the score
    score += e_count * 10
    score += word_score(words)
    score += @stars * 10
    score
  end

  def display
    puts ''
    puts '###################################################################################'
    puts "Overly Positive Score: #{@score}"
    puts '----------------------------------------------------------------------------------'
    puts "Rating: #{@stars / 10} Stars"
    puts '------------------------------------Review----------------------------------------'
    puts @full_text
    puts '###################################################################################'
    puts ''
  end

  def retreive_rating_from_class(entry)
    # find element with rating info
    rating_element = entry.xpath(".//div[contains(@class, 'rating-static hidden-xs')]")
    # get rating element's class attributes as a string
    rating_attr_str = rating_element[0].attributes.values[0].to_s
    # split attribute string into array of substrings
    attr_array = rating_attr_str.split
    # get the numeric part of the rating class ie: the '50' in 'rating-50'
    # then convert to integer
    attr_array[2][7, 8].to_i
  end

  def filter_text(str)
    d_str = str.downcase
    # convert the string into an array of words
    scan_array = d_str.scan(/[\w']+/)
    # filter out the words we don't care about
    scan_array.select! do |x|
      %w[perfect excellent love recommend good amazing great].include?(x)
    end

    # create a hash for the words
    words = Hash['love' => 0, 'excellent' => 0, 'perfect' => 0, 'recommend' => 0, 'good' => 0, 'great' => 0,
                 'amazing' => 0]

    # iterate through scan_array and add to words hash
    scan_array.each { |s| words[s] += 1 }
    words
  end

  def word_score(words)
    w_score = 0
    w_score += words['love'] * 6
    w_score += words['excellent'] * 5
    w_score += words['perfect'] * 4
    w_score += words['amazing'] * 3
    w_score += words['recommend']
    w_score += words['great'] * 2
    w_score + words['good']
  end
end
