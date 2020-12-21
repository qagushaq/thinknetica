require_relative 'validate'
require_relative 'instance_counter'
require_relative 'manufacturing_company'
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'car'
require_relative 'cargo_train'
require_relative 'cargo_car'
require_relative 'passenger_train'
require_relative 'passenger_car'

CAR_TYPES = {'cargo' => CargoCar, 'passenger' => PassengerCar}

def create_station # Создать станцию
  puts 'Введите название станции'
  name = gets.chomp
  Station.new(name)
  puts "Создана станция #{name}"
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def create_train # Создать поезд
  puts 'Введите номер поезда'
  number = gets.chomp
  raise "Поезд №#{number} уже существует" unless Train.find(number).nil?
  puts 'Выберите тип поезда: 1 - пассажирский, 2 - грузовой'
  type = gets.chomp.to_i
  raise "Вы неверно выбрали тип, нужно выбрат 1 или 2" unless [1, 2].include?(type)

  case type
  when 1
    PassengerTrain.new(number)
    puts "Создан пассажирский поезд №#{number}"
  when 2
    CargoTrain.new(number)
    puts "Создан грузовой поезд №#{number}"
  end
  rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry
end

def attach_car # Прицепить вагон к поезду
  raise 'Создайте поезд' if Train.all.empty?
  puts 'К какому поезду прицепить вагон ?'
  number = gets.chomp
  train = Train.find(number)
  raise 'Вы ввели номер несуществующего поезда' if train.nil?
  train.attach_car(CAR_TYPES[train.type].new)
  puts "Теперь у поезда №#{train.number} - #{train.cars.count} вагонов"
  rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry unless Train.all.empty?
end

def detach_car # Отцепить вагон от поезда
  raise 'Создайте поезд' if Train.all.empty?
  puts 'От какого поезда отцепить вагон ?'
  number = gets.chomp
  train = Train.find(number)
  raise 'Вы ввели номер несуществующего поезда' if train.nil?
  raise 'У этого поезда нет вагонов' if train.cars.empty?
  train.detach_car(train.cars.last)
  puts "Теперь у поезда №#{train.number} - #{train.cars.count} вагонов"
  rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry unless Train.all.empty?
end

def move_to_station # Поместить поезд на станцию
  raise 'Создайте поезд' if Trains.all.empty?
  raise 'Сначала необходимо создать станцию' if Stations.all.empty?
  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?
  puts 'Введите название станции, на которую нужно переместить поезд'
  name = gets.chomp
  station = Stations.all.detect { |station| station.name == name }
  raise 'Такой станции нет' if station.nil?
  station.get_train(train)
  rescue RuntimeError => e
    puts "Ошибка: #{e.message}"
end

def station_onfo # Просмотреть список станций
  raise "Вы еще не создали станции !" if Station.instances.nil?
  puts 'Список станций:'
  Station.all.each{|station| puts station.name}
  rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def train_info # Просмотреть список поездов на станции
  raise 'Сначала необходимо создать станцию' if Station.all.empty?
  puts 'Введите название станции'
  name = gets.chomp
  station = Station.all.detect{|station| station.name == name}
  raise 'Такой станции нет' if station.nil?
  station.show_trains
  rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

puts 'Что хотите сделать ?'
puts '1. Создать станцию'
puts '2. Создать поезд'
puts '3. Прицепить вагон к поезду'
puts '4. Отцепить вагон от поезда'
puts '5. Поместить поезд на станцию'
puts '6. Просмотреть список станций'
puts '7. Просмотреть список поездов на станции'
puts '0. Закончить работу'

loop do
  puts 'Что хотите сделать? '
  choose = gets.chomp.to_i

  case choose
  when 0 # Выход
    puts 'Выход'
    break

  when 1 # Создать станцию
    create_station

  when 2 # Создать поезд
    create_train

  when 3 # Прицепить вагон к поезду
    attach_car

  when 4 # Отцепить вагон от поезда
    detach_car

  when 5 # Поместить поезд на станцию
    move_to_station

  when 6 # Просмотреть список станций
    station_onfo

  when 7 # Просмотреть список поездов на станции
     train_info
   else
     puts 'Выбирайте из предложенных вариантов !!!'
   end
end
