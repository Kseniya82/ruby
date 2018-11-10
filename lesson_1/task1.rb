puts 'Введите ваше имя'
name = gets.chomp.capitalize
puts 'Веедите ваш рост'
growth = gets.to_i
ideal_weight = growth - 110
if ideal_weight >= 0
  puts "#{name}, ваш идеальный вес #{ideal_weight} кг"
else
  puts "#{name}, ваш вес уже оптимальный"
end
