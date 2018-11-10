puts 'Введите ваше имя'
name = gets.chomp.capitalize
puts 'Веедите ваш рост'
growth = gets.to_i
ideal_growth = growth - 110
if ideal_growth >= 0
  puts "#{name}, ваш идеальный вес #{ideal_growth} кг"
else
  puts "#{name}, ваш вес уже оптимальный"
end
