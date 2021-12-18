require './lib/review_checker.rb'
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

    describe 'collect_reviews'
        it 'cannot find reviews'

        it ' '

end