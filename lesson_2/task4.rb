letters = ("a".."z")
vowels_arr = ["a","e","i","o","u"]
vovels_hash = {}
letters_arr = letters.to_a
letters.each_with_index do |letter, index|
  vowels_hash[letter] = index + 1 if vowels_arr.include?(letter)
end
puts vowels_hash
