letters = ("a".."z")
vowels_arr = ["a","e","i","o","u"]
vovels_hash = {}
letters.each_with_index do |letter, index|
  vovels_hash[letter] = index + 1 if vowels_arr.include?(letter)
end
puts vovels_hash
