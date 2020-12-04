def output(sum)
  puts "Порядковый номер даты, начиная отсчет с начала года равен: #{sum}"
end

def sum(days_in_a_month, number, month, year)
  sum = 0
  for i in 0..month-2
    sum += days_in_a_month[i]
  end
  sum += number
  output(sum)
end

def check(days_in_a_month, number, month, year)
  if year % 400 == 0 || ( year % 4 == 0 && year % 100 != 0)
    puts 'Год високосный'
    days_in_a_month[1] = 29
  else
    puts 'Год не високосный'
  end
  sum(days_in_a_month, number, month, year)
end

def data
  days_in_a_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  puts ("Введите дату в формате дд.мм.гггг")
  mm_dd_yyyy = gets.chomp.split(".")
  mm_dd_yyyy.map! { |item| item = item.to_i }
  #добавить проверку на корректность введенной даты
  #if month > 12 || number > days_in_a_month[month - 1]
  number = mm_dd_yyyy[0]
  month = mm_dd_yyyy[1]
  year = mm_dd_yyyy[2]

  check(days_in_a_month, number, month, year)
end

data
