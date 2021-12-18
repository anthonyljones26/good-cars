require 'watir'
require 'webdrivers'
require 'nokogiri'
require './lib/review.rb'

class ReviewChecker
    attr_reader :reviews
    def initialize
        @reviews = []
    end
    def page_scrape(url)
        begin
            browser = Watir::Browser.new
            browser.goto url
            browser_html = Nokogiri::HTML(browser.html)
            #File.open("parsed.txt", "w") { |f| f.write "#{browser_html}" }
            browser.close
        rescue
            browser.close
            browser_html = nil
        end
        return browser_html
    end

    def parse_reviews(html)
        page_reviews = html.xpath("//div[contains(@class, 'review-entry')]")
        review_count = 0
        page_reviews.each do |review|
            r = Review.new(review)
            @reviews << r
        end

        return page_reviews.count
    end
end