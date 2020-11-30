puts "Введите a:"
a=gets.chomp.to_i
puts "Введите b:"
b=gets.chomp.to_i
puts "Введите c:"
c=gets.chomp.to_i
puts d= b**2 - 4*a*c
if d<0
  puts "Дискриминант=#{d},корней нет!"
elsif d>0
  x1 = ((-1)*b + Math.sqrt(d))/(2*a)
  x2 = ((-1)*b - Math.sqrt(d))/(2*a)
  puts "Дискриминант=#{d},корни уравнение:x1=#{x1.round(3)},x2=#{x2.round(3)} "
elsif    d==0
  x=((-1)*b)/(2*a)
    puts "Дискриминант=#{d},корни уравнение равны #{x.round(3)}"
end
