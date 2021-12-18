require './lib/review_checker.rb'

#Create new review checker
rc = ReviewChecker.new

#scrape first page of reviews
page1 = rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page2/?filter=#link')
puts rc.parse_reviews(page1)
#parse page one
