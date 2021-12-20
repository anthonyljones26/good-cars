# frozen_string_literal: true

require './lib/review_checker'
RSpec.describe ReviewChecker do
  describe 'page_scrape' do
    it 'cannot reach invalid url' do
      rc = ReviewChecker.new
      expect(rc.page_scrape('')).to be(nil)
    end
    it 'reaches valid url' do
      rc = ReviewChecker.new
      valid_url = 'https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link'
      expect(rc.page_scrape(valid_url)).to_not be(nil)
    end
  end

  describe 'process_reviews' do
    it 'cannot process reviews when passed ' do
      rc = ReviewChecker.new
      prev_count = rc.reviews.count
      rc.process_reviews(nil)

      expect(rc.reviews.count).to eq(prev_count)
    end

    it 'successfully processes reviews' do
      rc = ReviewChecker.new
      prev_count = rc.reviews.count
      browser_html = File.read('spec/fixtures/html/dealerrater_review_page.html')
      rc.process_reviews(Nokogiri::HTML(browser_html))

      expect(rc.reviews.count).to be > prev_count
      expect(rc.reviews.count).to eq(10)
    end
  end
end
