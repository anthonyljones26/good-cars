require 'nokogiri'

class Review
    @stars = 0
    @text = ""
    @score = 0
    @title = ""
    @full_text = ""
    def initialize(entry)
        # find review title text in review entry
        @title = entry.xpath(".//span[contains(@class, 'review-title')]").text

        # find review whole text in review entry
        @text = entry.xpath(".//span[contains(@class, 'review-whole')]").text

        @full_text = @title + @text

        # retreive the review rating value from class
        rating_element = entry.xpath(".//div[contains(@class, 'rating-static hidden-xs')]")
        rating_attr_str = rating_element[0].attributes.values[0].to_s
        attr_array = rating_attr_str.split
        @stars = attr_array[2][7,8].to_i

        @score = calc_score
         
    end

    def calc_score
        score = 0;
        str = @full_text

        #count the '!'
        e_count = str.count('!')
        puts e_count
        #downcase the whole string for normalization
        d_str = str.downcase
        #convert the string into an array of words
        scanArray = d_str.scan(/[\w']+/)
        
        #filter out the words we don't care about
        scanArray.select! {|x| x == 'perfect' || x == 'excellent' || x == 'love' || x == 'recommend' || x == 'good'}
        puts scanArray
        
        #create a hash for the words
        words = Hash['love' => 0, 'excellent' => 0, 'perfect' => 0, 'recommend' => 0, 'good' => 0]
        
        #iterate through scanArray and add to words hash
        scanArray.each do |s|
            words[s] += 1
        end
        
        puts words
        
        #calculate the score
        score += e_count * 10
        score += words['love'] * 5
        score += words['excellent'] * 4
        score += words['perfect'] * 3
        score += words['recommend'] * 2
        score += words['good']
        score += @stars * 10
        puts score

        return score
    end
end