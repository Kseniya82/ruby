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
#triangle=false #признак трeугольника
#angle_90=false
valid_triangle = ab < bc + ac && ab > (bc - ac).abs
sides = [ab, bc, ac].sort
angle_90 = sides[-1]**2 == sides[0]**2 + sides[1]**2
equals_2sides = sides[0] == sides[1] if angle_90
equals_3sides = sides[0] == sides[1] && sides[1] == sides[-1]
if equals_2sides
  puts "Треугольник является прямоугольным и равнобедренным"
elsif angle_90
  puts 'Треугольник является прямоугольным'
end
puts "Треугольник является равносторонни" if equals_3sides
puts 'По введенным значениям сторон нельзя построить треугольник' unless valid_triangle
