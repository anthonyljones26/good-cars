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

  def page_scrape(url)
    begin
      browser = Watir::Browser.new
      browser.goto url
      #puts "browser.html.class = #{browser.html}"
      browser_html = Nokogiri::HTML(browser.html)
      browser.close
    rescue StandardError
      browser.close
      browser_html = nil
    end
    #puts "browser_html.class = #{browser_html}"
    #File.open("dealership_review_page.txt", "w") { |f| f.write "#{browser.html}" }
    browser_html
  end

  def process_reviews(html)
    return if html.nil?

    page_reviews = html.xpath("//div[contains(@class, 'review-entry')]")
    page_reviews.each do |review|
      r = Review.new(review)
      @reviews << r
    end
  end
end
