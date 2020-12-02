cart = {}
sum = 0
loop do
  puts 'Название товара:'
  name = gets.chomp
  break if name == 'стоп' || name == 'stop' || name == 's'
  puts 'Цена за единицу:'
  price = gets.chomp.to_f
  puts "Количество:"
  count = gets.chomp.to_f
  sum_each = price * count
  cart[name] = {"price" => price, "count" =>  count, "total for this product" => sum_each}
  puts "Итоговая сумма за #{name} составила: #{sum_each}"
end

cart.each do |key,value|
  sum += value["price"] * value["count"]
end
puts cart
puts "Итоговая стоимость всех покупок составила: #{sum}$"
