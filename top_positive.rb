# frozen_string_literal: true

require './lib/review_checker'

# Create new review checker
rc = ReviewChecker.new
success = true

(1..5).each do |n|
  page = rc.page_scrape("https://www.dealerrater.com/dealer/McKaig-Chevrolet-Buick-A-Dealer-For-The-People-dealer-reviews-23685/page#{n}/?filter=#link")
  if page.nil?
    success = false
    break
  end
  rc.process_reviews(page)
end
puts rc.reviews.count
if success
  # sort the array of review objects by score in descending order
  rc.reviews.sort_by! { |r| -r.score }
  if rc.reviews.count >= 3
    puts rc.reviews[0].display
    puts rc.reviews[1].display
    puts rc.reviews[2].display
  elsif rc.reviews.count.positive? && rc.reviews.count < 3
    rc.reviews.each(&:display)
  else
    puts 'No reviews found'
  end
else
  puts 'Error scraping reviews'
end
