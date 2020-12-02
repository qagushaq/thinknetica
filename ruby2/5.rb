puts 'Введите число:'
number = gets.chomp.to_i
puts 'Введите месяц:'
month = gets.chomp.to_i
puts 'Введите год:'
year = gets.chomp.to_i

days_in_a_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
if year % 400 == 0 || ( year % 4 == 0 && year % 100 != 0)
  puts 'Год високосный'
  days_in_a_month[1] = 29
else
  puts 'Год не високосный'
end

sum = 0

for i in 0..month-2
  sum += days_in_a_month[i]
end
sum += number
puts "Порядковый номер даты, начиная отсчет с начала года равен: #{sum}"
