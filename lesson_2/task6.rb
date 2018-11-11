my_cart = Hash.new { Hash.new }
puts "Введите наименование товара или слово стоп для окончания ввода покупок"
product = gets.chomp
until product.upcase == "СТОП"
  puts "Введите цену за единицу товара"
  price_product = gets.to_f
  puts "Введите кол-во товара"
  count_product = gets.to_i
  my_cart[product]={price_product => count_product}
  puts "Введите наименование товара или слово стоп для окончания ввода покупок"
  product = gets.chomp
end
total_cost = 0
my_cart.each do |key, value|
  value.each do |price, count|
    cost = price * count
    total_cost += cost
    puts "Продукт: #{key}, цена: #{price}, кол-во: #{count} стоимость #{cost}"
  end
end
puts "Итоговаястоимость товаров в корзине: #{total_cost}"
