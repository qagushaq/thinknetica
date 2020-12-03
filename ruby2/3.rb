#Заполнить массив числами фибоначчи до 100
fib = [0, 1]
while ( next_fib = fib[-1] + fib[-2] ) <= 100
  fib << next_fib
end
puts fib
