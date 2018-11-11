month_hash = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31,
}

puts "Введите число интересующей даты: "
date_day = gets.to_i
puts "Введите месяц интересующей даты: "
date_month = gets.to_i
puts "Введите год интересующей даты: "
date_year = gets.to_i
count_day_to_date = 0
month_hash.each do |month, count_day|
  count_day_to_date += count_day if month < date_month
end
count_day_to_date += date_day
valid_leap_year = (date_year % 4 == 0) && ((date_year % 100 > 0) || (date_year % 400 == 0))
count_day_to_date += 1 if valid_leap_year && date_month > 2
puts "Кол-во дней с начала года до интересующей даты #{count_day_to_date}"
