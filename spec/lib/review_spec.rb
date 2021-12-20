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
      entry_html = File.read('spec/fixtures/html/review_entry_valid.html')
      entry = Nokogiri::HTML(entry_html)
      review_entry = entry.xpath("//div[contains(@class, 'review-entry')]")[0]

      it 'will populate object with values' do
        test_review = Review.new(review_entry)
        expect(test_review.stars).to eq(50)
        expect(test_review.score).to eq(509)
        expect(test_review.full_text).to eq(File.read('spec/fixtures/text/full_review.txt'))
      end
    end

    context 'when input is valid and html is missing elements' do
      entry_html = File.read('spec/fixtures/html/review_entry_partial.html')
      entry = Nokogiri::HTML(entry_html)
      review_entry = entry.xpath("//div[contains(@class, 'review-entry')]")[0]

      it 'will populate object with available values' do
        test_review = Review.new(review_entry)
        expect(test_review.stars).to eq(50)
        expect(test_review.score).to eq(506)
        expect(test_review.full_text).to eq(File.read('spec/fixtures/text/partial_review.txt'))
      end
    end
  end
end
