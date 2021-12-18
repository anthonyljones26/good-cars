require './lib/review_checker.rb'

#Create new review checker
rc = ReviewChecker.new

#scrape first page of reviews
page1 = rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page1/?filter=#link')
rc.parse_reviews(page1)

#scrape second page of reviews
page2 = rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page2/?filter=#link')
rc.parse_reviews(page2)

#scrape third page of reviews
page3 = rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page3/?filter=#link')
rc.parse_reviews(page3)

#scrape fourth page of reviews
page4 = rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page4/?filter=#link')
rc.parse_reviews(page4)

#scrape fourth page of reviews
page5 = rc.page_scrape('https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page5/?filter=#link')
rc.parse_reviews(page5)

puts rc.reviews.inspect

