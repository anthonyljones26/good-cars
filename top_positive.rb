require './lib/review_checker.rb'

#Create new review checker
rc = ReviewChecker.new

(1..5).each do |n|
    page = rc.page_scrape("https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page#{n}/?filter=#link")
    rc.parse_reviews(page)
end

#sort the array of review objects by score in descending order
rc.reviews.sort_by! { |r| -r.score }

puts rc.reviews[0].display
puts rc.reviews[1].display
puts rc.reviews[2].display