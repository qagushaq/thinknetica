def check_tr a,b,c
    if a + b > c && a + c > b && b + c > a
        print("Треугольник существует\n")
    else
        print("Треугольник не существует\n")
    end
end

puts "Введите 1 сторону треугольника:"
a=gets.chomp.to_i
puts "Введите 2 сторону треугольника:"
b=gets.chomp.to_i
puts "Введите 3 сторону треугольника:"
c=gets.chomp.to_i

check_tr a,b,c

arr =[a, b, c]
if arr[-1]**2 == arr[-2]**2 + arr[-3]**2
  puts "Треугольник является прямоугольным"
  else
    if
      arr[-1]==arr[-2] && arr[-1]==arr[-3]
      puts "Треугольник является равносторонним и равнобедренным"
    elsif
      arr[-1]==arr[-2] || arr[-1]==arr[-3] || arr[-2]==arr[-3]
      puts "Треугольник является равнобедренным"
    else
      puts "Треугольник является обычным)"
    end
end
