require 'nokogiri'

class Review
    @stars = 0
    @text = ""
    @score = 0
    @title = ""
    def initialize(entry)
        @title = entry.xpath(".//span[contains(@class, 'review-title')]").text
        @text = entry.xpath(".//span[contains(@class, 'review-whole')]").text

        rating_element = entry.xpath(".//div[contains(@class, 'rating-static hidden-xs')]")
        rating_attr_str = rating_element[0].attributes.values[0].to_s
        attr_array = rating_attr_str.split
        @stars = attr_array[2][7,8].to_i
         
    end

    def calc_score
        temp_score = 0;
    end
end