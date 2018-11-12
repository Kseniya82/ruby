month_hash = {
  janvary: 31,
  febrary: 28,
  march: => 31,
  april: => 30,
  may: => 31,
  june: => 30,
  jule: => 31,
  august: => 31,
  september: => 30,
  oktober: => 31,
  november: => 30,
  december: => 31,
}
month_hash.each do |month, count_day|
  puts month if count_day == 30
end
