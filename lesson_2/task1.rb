month_hash = {
  Janvary: 31,
  Febrary: 28,
  March: => 31,
  April: => 30,
  May: => 31,
  June: => 30,
  Jule: => 31,
  August: => 31,
  September: => 30,
  Oktober: => 31,
  November: => 30,
  December: => 31,
}
month_hash.each do |month, count_day|
  puts month if count_day == 30
end
