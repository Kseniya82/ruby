puts 'Введите ваше имя'
name=gets.chomp
puts 'Веедите ваш рост'
growth=gets.chomp.to_i
if growth-110>=0
  puts "#{name}, ваш идеальный вес #{growth-110} кг"
else
  puts "#{name}, ваш вес уже оптимальный"
end
