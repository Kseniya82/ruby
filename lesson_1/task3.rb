=begin
в данном варианте на равнобедренность
проверяются только прямоугольные треугольники, согласно условиям
задачи для непрямоугольного равностороннего треугольника
сообщений не предусмотрено
=end

puts "Введите 1 сторону треугольника"
ab=gets.chomp.to_i
puts "Введите 2 сторону треугольника"
ac=gets.chomp.to_i
puts "Введите 3 сторону треугольника"
bc=gets.chomp.to_i
triangle=false #признак трeугольника
angle_90=false
triangle=true if ab<bc+ac && ab>(bc-ac).abs
if triangle && ab>bc && ab>ac
  if ab**2==bc**2+ac**2
    puts 'Треугольник является прямоугольным'
    agle_90=true
  end
elsif triangle && bc>ac
  if bc**2==ab**2+ac**2
    puts 'Треугольник является прямоугольным'
    agle_90=true
  end
else
  if (bc**2==ab**2+ac**2) && triangle
    puts 'Треугольник является прямоугольным'
    agle_90=true
  end
end

if angle_90 && triangle && (ab==bc || bc==ac)
  puts "Треугольник является равнобедренным"
elsif ab==bc && ac==bc
  puts 'Треугольник является равносторонним'
end

puts 'По введенным значениям сторон нельзя построить треугольник' unless triangle
