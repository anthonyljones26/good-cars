# frozen_string_literal: true

require 'nokogiri'
require './lib/review'

RSpec.describe Review do
  describe 'On initialization' do
    context 'when input is nil' do
      it 'has default values' do
        test_review = Review.new(nil)
        expect(test_review.stars).to eq(0)
        expect(test_review.score).to eq(0)
        expect(test_review.full_text).to eq('')
      end
    end

    context 'when input is valid' do
      entry_html = File.read('spec/fixtures/review_entry_valid.html')
      entry = Nokogiri::HTML(entry_html)
      review_entry = entry.xpath("//div[contains(@class, 'review-entry')]")[0]

      it 'will populate object with values' do
        test_review = Review.new(review_entry)
        expect(test_review.stars).to eq(50)
        expect(test_review.score).to eq(509)
        expect(test_review.full_text).to eq("We was treated with great respect and have all good things to say about ya'll every one was so nice we no where to go to get our next thank you so much for all you did for use we love our new car")
      end
    end

    context 'when input is valid and html is missing elements' do
      entry_html = File.read('spec/fixtures/review_entry_parital.html')
      entry = Nokogiri::HTML(entry_html)
      review_entry = entry.xpath("//div[contains(@class, 'review-entry')]")[0]

      it 'will populate object with available values' do
        test_review = Review.new(review_entry)
        expect(test_review.stars).to eq(50)
        expect(test_review.score).to eq(506)
        expect(test_review.full_text).to eq(" things to say about ya'll every one was so nice we no where to go to get our next thank you so much for all you did for use we love our new car")
      end
    end
  end
end
