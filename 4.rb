puts 'Введите a:'
a = gets.chomp.to_i
puts 'Введите b:'
b = gets.chomp.to_i
puts 'Введите c:'
c = gets.chomp.to_i
d = b**2 - 4 * a * c
if d.negative?
  puts "Дискриминант=#{d},корней нет!"
elsif d.positive?
  r = Math.sqrt(d)
  x1 = (-b + r) / (2 * a)
  x2 = (-b - r) / (2 * a)
  puts "Дискриминант=#{d},корни уравнение:x1=#{x1.round(3)},x2=#{x2.round(3)} "
elsif d.zero?
  x = (-b) / (2 * a)
  puts "Дискриминант=#{d},корни уравнение равны #{x.round(3)}"
end
