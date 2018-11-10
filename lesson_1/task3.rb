=begin
в данном варианте на равнобедренность
проверяются только прямоугольные треугольники, согласно условиям
задачи для непрямоугольного равностороннего треугольника
сообщений не предусмотрено
=end

puts "Введите 1 сторону треугольника"
ab = gets.to_i
puts "Введите 2 сторону треугольника"
ac = gets.to_i
puts "Введите 3 сторону треугольника"
bc = gets.to_i
valid_triangle = ab < bc + ac && ab > (bc - ac).abs
sides = [ab, bc, ac].sort
angle_90 = sides[-1]**2 == sides[0]**2 + sides[1]**2
isosceles_right_triangle = sides[0] == sides[1] && angle_90
equilateral_triangle = sides[0] == sides[-1]
if !valid_triangle
  puts 'По введенным значениям сторон нельзя построить треугольник'
elsif isosceles_right_triangle
  puts "Треугольник является прямоугольным и равнобедренным"
elsif angle_90
  puts 'Треугольник является прямоугольным'
elsif equilateral_triangle
  puts "Треугольник является равносторонни"
else
  puts 'Треугольник не является ни пряомугольным ни равносторонним'
end
