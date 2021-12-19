# frozen_string_literal: true

require './lib/review_checker'
RSpec.describe ReviewChecker do
  describe 'page_scrape' do
    it 'cannot reach url' do
      rc = ReviewChecker.new
      expect(rc.page_scrape('')).to be(nil)
    end
    it 'reaches url' do

      rc = ReviewChecker.new
      expect(rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link')).to_not be(nil)
    end
  end

  describe 'process_reviews' do
    it 'cannot process reviews' do
      rc = ReviewChecker.new
      prev_count = rc.reviews.count
      rc.process_reviews(nil)

      expect(rc.reviews.count).to eq(prev_count)
    end

    it 'successfully processes reviews' do
      rc = ReviewChecker.new
      prev_count = rc.reviews.count
      browser_html = File.read('spec\fixtures\dealerrater_review_page.html')
      #entry = Nokogiri::HTML(browser_html)
      rc.process_reviews(Nokogiri::HTML(browser_html))

      expect(rc.reviews.count).to be > prev_count
      expect(rc.reviews.count).to eq(10) 
    end
  end
end
