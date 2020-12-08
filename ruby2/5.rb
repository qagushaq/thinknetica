def leap_year?(year)
  (year % 400).zero? || ((year % 4).zero? && year % 100 != 0)
end

def days_in_february(year)
  leap_year?(year) ? 29 : 28
end

def months_by_year(year)
  [31, days_in_february(year), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
end

def calc_total(day, month, year)
  return day if month == 1
  print "Порядковый номер даты, начиная отсчет с начала года равен: "
  months_by_year(year).first(month - 1).sum + day
end

def get_data
  puts ("Введите дату в формате дд.мм.гггг")
  mm_dd_yyyy = gets.chomp.split(".")
  mm_dd_yyyy.map! { |item| item = item.to_i }
  day = mm_dd_yyyy[0]
  month = mm_dd_yyyy[1]
  year = mm_dd_yyyy[2]
  return day, month, year
end

day, month, year = get_data
while (month > 12 || day > months_by_year(year)[month-1]) == true
  puts ("Вы ввели некорректную дату. Повторите ввод.")
  day, month, year = get_data
  break if (month > 12 || day > months_by_year(year)[month-1]) == false
end

puts calc_total(day, month, year)
