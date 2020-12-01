def check_tr(a, b, c)
  if a + b > c && a + c > b && b + c > a
    print("Треугольник существует\n")
  else
    print("Треугольник не существует\n")
  end
end

puts 'Введите 1 сторону треугольника:'
a = gets.chomp.to_i
puts 'Введите 2 сторону треугольника:'
b = gets.chomp.to_i
puts 'Введите 3 сторону треугольника:'
c = gets.chomp.to_i

check_tr(a, b, c)

max=[a, b, c].max
min=[a, b, c].min(2)
min1=min[0]
min2=min[1]

if max**2 == min1**2 + min2**2
  puts 'Треугольник является прямоугольным'
else
  if
    max == min1 && max == min2
    puts 'Треугольник является равносторонним и равнобедренным'
  elsif
    max == min1 || max == min2 || min1 == min2
    puts 'Треугольник является равнобедренным'
  else
    puts 'Треугольник является обычным)'
  end
end



=begin

arr = [a, b, c]
if arr[-1]**2 == arr[-2]**2 + arr[-3]**2
  puts 'Треугольник является прямоугольным'
else
  if
    arr[-1] == arr[-2] && arr[-1] == arr[-3]
    puts 'Треугольник является равносторонним и равнобедренным'
  elsif
    arr[-1] == arr[-2] || arr[-1] == arr[-3] || arr[-2] == arr[-3]
    puts 'Треугольник является равнобедренным'
  else
    puts 'Треугольник является обычным)'
  end
end

=end
