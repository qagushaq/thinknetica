require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'car'
require_relative 'cargo_train'
require_relative 'cargo_car'
require_relative 'passenger_train'
require_relative 'passenger_car'


trains = []
stations = []

puts "Что хотите сделать ?"
puts "1. Создать станцию"
puts "2. Создать поезд"
puts "3. Прицепить вагон к поезду"
puts "4. Отцепить вагон от поезда"
puts "5. Поместить поезд на станцию"
puts "6. Просмотреть список станций"
puts "7. Просмотреть список поездов на станции"
puts "0. Закончить работу"

loop do
  puts "Что хотите сделать? "
  choose = gets.chomp.to_i
  case choose

  when 0
    puts "Выход"
    break

  when 1
    puts "Введите название станции"
    name = gets.chomp
    stations << Station.new(name)

  when 2
    puts "Введите номер поезда"
    number = gets.chomp
    puts "Выберите тип поезда: 1 - грузовой поезд, 0 - пассажирский"
    type = gets.chomp
    case type
    when 1
      trains << CargoTrain.new(number)
      puts "Создан грузовой поезд №#{number}"
    when 0
      trains << PassengerTrain.new(number)
      puts "Создан пассажирский поезд №#{number}"
    else
      puts "Поезд не был создан, вы неверно указали параметры"
    end


  when 3 #Прицепить вагон к поезду
  when 4 #Отцепить вагон от поезда
  when 5 #Поместить поезд на станцию
  when 6
    puts "Список станций"
    stations.each{|station| puts station.name}
  when 7 #Просмотреть список поездов на станции














  end
end
