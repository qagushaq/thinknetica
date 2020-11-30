puts "Добрый день, как вас зовут ?"
name=gets.chomp.capitalize!
puts "Введите Ваш рост"
height=gets.chomp.to_i
puts "Введите Ваш вес"
weight=gets.chomp.to_i
ideal= (height-110)*1.15
if ideal<0
  puts "#{name}, Ваш вес уже оптимальный!!!"
else
  puts "#{name}, Ваш идеальный вес: #{ideal}"
end
