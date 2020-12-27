require_relative 'accessors'
require_relative 'validation'
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

CAR_TYPES = { 'cargo' => CargoCar, 'passenger' => PassengerCar }.freeze

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
  puts 'Введите номер поезда в формате (ххххх или ххх-хх)'
  number = gets.chomp
  raise "Поезд №#{number} уже существует" unless Train.find(number).nil?

  puts 'Выберите тип поезда: 1 - пассажирский, 2 - грузовой'
  type = gets.chomp.to_i
  raise 'Вы неверно выбрали тип, нужно выбрат 1 или 2' unless [1, 2].include?(type)

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

  if train.type == 'cargo'
    puts 'Введите объем вагона'
    size = gets.chomp.to_f
  elsif train.type == 'passenger'
    puts 'Введите количество мест в вагоне'
    size = gets.chomp.to_i
  end
  train.attach_car(CAR_TYPES[train.type].new(size))
  puts "Теперь у поезда №#{train.number} - #{train.cars.count} вагонов"
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
  retry unless Train.all.empty?
end

def detach_car # Отцепить вагон от поезда
  raise 'Создайте поезд!' if Train.all.empty?

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
  raise 'Создайте поезд' if Train.all.empty?
  raise 'Сначала необходимо создать станцию' if Station.all.empty?

  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Поезда с таким номером нет' if train.nil?

  puts 'Введите название станции, на которую нужно переместить поезд'
  name = gets.chomp
  station = Station.all.detect { |station| station.name == name }
  raise 'Такой станции нет' if station.nil?

  station.get_train(train)
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def station_info # Просмотреть список станций
  raise 'Вы еще не создали станции !' if Station.instances.nil?

  puts 'Список станций:'
  Station.all.each { |station| puts station.name }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def train_info # Просмотреть список поездов на станции
  raise 'Сначала необходимо создать станцию' if Station.all.empty?

  puts 'Введите название станции'
  name = gets.chomp
  station = Station.all.detect { |station| station.name == name }
  raise 'Такой станции нет' if station.nil?

  station.iterate_trains { |train| puts "Номер поезда: №#{train.number}, Тип:#{train.type}, #{train.cars.count}-вагонов " }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def car_info # Просмотреть список вагонов у поезда
  raise 'Создайте поезд' if Train.all.empty?

  puts 'Введите номер поезда.'
  number = gets.chomp
  train = Train.find(number)
  raise 'Вы ввели номер несуществующего поезда' if train.nil?

  car_number = 0
  train.iterate_cars { |car| puts "№#{car_number += 1}, Тип:#{train.type}, свободно-#{car.free}, занято-#{car.filled}" }
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

def load_car # Загрузить вагон
  raise 'Создайте поезд!' if Train.all.empty?

  puts 'Введите номер поезда'
  number = gets.chomp
  train = Train.find(number)
  raise 'Вы ввели номер несуществующего поезда' if train.nil?

  puts 'Введите номер вагона'
  car_number = gets.chomp.to_i
  raise 'Такого вагона в поезде нет' if car_number > train.cars.size

  if train.type == 'cargo'
    puts 'Введите объем груза'
    train.cars[car_number - 1].load(gets.chomp.to_f)
  elsif train.type == 'passenger'
    train.cars[car_number - 1].take_seat
  end
  puts 'Вагон(ы) успешно заполнены'
rescue RuntimeError => e
  puts "Ошибка: #{e.message}"
end

puts %(
Что хотите сделать ?
0. Закончить работу
1. Создать станцию
2. Создать поезд
3. Прицепить вагон к поезду
4. Отцепить вагон от поезда
5. Поместить поезд на станцию
6. Просмотреть список станций
7. Просмотреть список поездов на станции
8. Просмотреть список вагонов у поезда
9. Заполнить вагоны в поезде
  )

loop do
  puts 'Что хотите сделать?'
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
    station_info

  when 7 # Просмотреть список поездов на станции
    train_info

  when 8 # Просмотреть список вагонов у поезда
    car_info

  when 9 # Загрузить вагон
    load_car

  else
    puts 'Выбирайте из предложенных вариантов !!!'
  end
end
