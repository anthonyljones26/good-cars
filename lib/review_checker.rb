# frozen_string_literal: true

require 'watir'
require 'webdrivers'
require 'nokogiri'
require './lib/review'

# This class scrapes reviews from dealrater.com then puts them in an array of review objects
class ReviewChecker
  attr_reader :reviews

  def initialize
    @reviews = []
  end

  # Scrapes the page of the input url and returns Nokogiri::HTML::Document
  def page_scrape(url)
    begin
      browser = Watir::Browser.new :firefox, headless: true
      browser.goto url
      browser_html = Nokogiri::HTML(browser.html)
      browser.close
    rescue StandardError
      browser&.close
      browser_html = nil
    end
    browser_html
  end

  # Converts review entries into review objects and adds them to reviews array
  def process_reviews(html)
    return if html.nil?

    page_reviews = html.xpath("//div[contains(@class, 'review-entry')]")
    page_reviews.each do |review|
      r = Review.new(review)
      @reviews << r
    end
  end
end
