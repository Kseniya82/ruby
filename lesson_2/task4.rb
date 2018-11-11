letters = ("a".."z")
vowels_arr = ["a","e","i","o","u"]
vawels_hash = {}
letters_arr = letters.to_a
letters.each_with_index do |letter, index|
  vawels_hash[letter] = index + 1 if vowels_arr.any?(letter)
end
puts vawels_hash
