day_in_month_arr= [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts "Введите число интересующей даты: "
date_day = gets.to_i
puts "Введите месяц интересующей даты: "
date_month = gets.to_i
puts "Введите год интересующей даты: "
date_year = gets.to_i
count_day_to_date = day_in_month_arr.take(date_month - 1).sum
count_day_to_date += date_day
valid_leap_year = (date_year % 4 == 0) && ((date_year % 100 > 0) || (date_year % 400 == 0))
count_day_to_date += 1 if valid_leap_year && date_month > 2
puts "Кол-во дней с начала года до интересующей даты #{count_day_to_date}"
