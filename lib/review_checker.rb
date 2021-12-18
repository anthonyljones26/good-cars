require 'watir'
require 'webdrivers'
require 'nokogiri'
require './lib/review.rb'

class ReviewChecker
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
        puts page_reviews.class
        puts page_reviews[0].class
        #puts page_reviews[0]
        #puts page_reviews.xpath("//span[contains(@class, 'review-title')]")[0]
        page_reviews.each_with_index do |review, i|
            puts i
            title =  review.xpath(".//span[contains(@class, 'review-title')]/text()")
            whole =  review.xpath(".//span[contains(@class, 'review-whole')]/text()")
            #puts title.to_s + whole.to_s
            rating_element = review.xpath(".//div[contains(@class, 'rating-static hidden-xs')]")
            rating_attr_str = rating_element[0].attributes.values[0].to_s
            attr_array = rating_attr_str.split
            #puts attr_array[2][7,8]
            #puts review.xpath("//div[contains(@class, 'rating-50') and contains(@class, 'rating-static') and contains(@class, 'hidden-xs')]")[i]
            r = Review.new(review)
            puts r.inspect
        end

        return page_reviews.count
    end

    #def convert_review(entry)
    #    r = Review.new
    #   r.stars = entry.xpath("//div[contains(@class, 'review-entry')]")
    #end
end