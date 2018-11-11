letters = ("a".."z")
vowels_arr = ["a","e","i","o","u"]
vawels_hash = Hash.new
letters_arr = letters.to_a
vowels_arr.each do |vowel|
  index = letters_arr.index(vowel)
  vawels_hash[vowel] = index + 1
end
puts vawels_hash
