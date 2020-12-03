puts ("Введите дату в формате дд.мм.гггг")
mm_dd_yyyy = gets().chomp.split(".")
mm_dd_yyyy.map! {|item| item = item.to_i }

number = mm_dd_yyyy[0]
month = mm_dd_yyyy[1]
year = mm_dd_yyyy[2]

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
