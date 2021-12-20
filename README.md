# good-cars

This is a ruby application that displays the top 3 overly positive reviews for McKaig Chevrolet Buick on dealerrater.com

## Prerequisites
* Need internet connection
* [Install Ruby](https://www.ruby-lang.org/en/documentation/installation/) version 2.7 or higher
* after installing ruby, [install bundler](https://bundler.io/) version 2.1.2 or higher
## Setup
* run bundle install  
  `bundle install`
## Running the application
1. Navigate to project (`cd path/to/project`)  
2. Run ruby top_positive.rb from the root directory of this project  
  `ruby top_positive.rb`
## Running the test suit
1. Navigate to project (`cd path/to/project`)  
2. Run rspec from the root directory of this project  
  `rspec`
## Criteria for calculating an overly positive review
* An overly positive score is calculated by adding up the following
  * The star rating, ranging from 0 to 50. Then multiplied by 10  
    `47 * 10 = 470` 
  * The number of excalmations "!" in the text of the review multiplied by 10
    * In the text *"GREAT! Customer service!! I would love to come back to buy another amazing car!"*
    * there are 4 "!" which means `4 * 10 = 40`  
  * The number of times specific words occur in the text with different multipliers  
    "love" = 6  
    "excellent" = 5  
    "perfect" = 4  
    "amazing" = 3  
    "great" = 2  
    "recommend" and "good" = 1
    * The text *"GREAT! Customer service!! I would love to come back to buy another amazing car!"*  
    * could be reduced to: `great + love + amazing` which equals `2 + 6 + 3 = 11`  
  * Give the examples above, the total score would be 521  
    `470 + 40 + 11 = 521` 