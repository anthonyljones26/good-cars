require 'nokogiri'

class Review
    attr_reader :score
    attr_reader :full_text
    attr_reader :stars

    @stars = 0
    @score = 0
    @full_text = ""
    def initialize(entry)
        # find review title text in review entry
        title = entry.xpath(".//span[contains(@class, 'review-title')]").text

        # find review whole text in review entry
        text = entry.xpath(".//span[contains(@class, 'review-whole')]").text

        @full_text = title + text

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

        #downcase the whole string for normalization
        d_str = str.downcase
        #convert the string into an array of words
        scanArray = d_str.scan(/[\w']+/)
        
        #filter out the words we don't care about
        scanArray.select! {|x| x == 'perfect' || x == 'excellent' || x == 'love' || x == 'recommend' || x == 'good' || x == 'amazing' || x == 'great'}
        
        #create a hash for the words
        words = Hash['love' => 0, 'excellent' => 0, 'perfect' => 0, 'recommend' => 0, 'good' => 0, 'great' => 0, 'amazing' => 0]
        
        #iterate through scanArray and add to words hash
        scanArray.each do |s|
            words[s] += 1
        end
        
        #calculate the score
        score += e_count * 10
        score += words['love'] * 6
        score += words['excellent'] * 5
        score += words['perfect'] * 4
        score += words['amazing'] * 3
        score += words['recommend']
        score += words['great'] * 2
        score += words['good']
        score += @stars * 10
        return score
    end

    def display
        puts '###################################################################################'
        puts "Rating: #{@stars/10} Stars"
        puts "------------------------------------Review----------------------------------------"
        puts @full_text
        puts '###################################################################################'
    end
end