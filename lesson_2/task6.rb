my_cart = {}
puts "Введите наименование товара или слово стоп для окончания ввода покупок"
product = gets.chomp
until product.upcase == "СТОП"
  puts "Введите цену за единицу товара"
  price_product = gets.to_f
  puts "Введите кол-во товара"
  count_product = gets.to_i
  my_cart[product]={ price: price_product, quantity: count_product }
  puts "Введите наименование товара или слово стоп для окончания ввода покупок"
  product = gets.chomp
end
total_cost = 0
my_cart.each do |name, info|
  cost = info[:price] * info[:quantity]
  total_cost += cost
  puts "Продукт: #{name}, цена: #{info[:price]}, кол-во: #{info[:quantity]} стоимость #{cost}"
end
puts "Итоговая стоимость товаров в корзине: #{total_cost}"
