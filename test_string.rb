str = "pErfeCt CAR!!! perfect don't DEAL! excellent experience buying a car excellent service. I love to recommend a good time."

#count the '!'
e_count = str.count('!')
puts e_count
#downcase the whole string for normalization
str = str.downcase
#convert the string into an array of words
scanArray = str.scan(/[\w']+/)

#filter out the words we don't care about
scanArray.select! {|x| x == 'perfect' || x == 'excellent' || x == 'love' || x == 'recommend' || x == 'good'}
puts scanArray

#create a hash for the words
words = Hash['love' => 0, 'excellent' => 0, 'perfect' => 0, 'recommend' => 0, 'good' => 0]
puts words

#iterate through scanArray and add to words hash
scanArray.each do |s|
    words[s] += 1
end

puts words

#calculate the score
score = 0
score += e_count * 10
score += words['love'] * 5
score += words['excellent'] * 4
score += words['perfect'] * 3
score += words['recommend'] * 2
score += words['good']
puts score