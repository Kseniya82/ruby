day_in_month_arr= [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
puts "Введите число интересующей даты: "
date_day = gets.to_i
puts "Введите месяц интересующей даты: "
date_month = gets.to_i
puts "Введите год интересующей даты: "
date_year = gets.to_i
leap_year = date_year % 4 == 0 && date_year % 100 > 0 || date_year % 400 == 0
day_in_month_arr[1] += 1 if leap_year
count_day_to_date = date_day + day_in_month_arr.take(date_month - 1).sum
puts "Кол-во дней с начала года до интересующей даты #{count_day_to_date}"
