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
CAR_TYPES = {'cargo' => CargoCar, 'passenger' => PassengerCar}

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
    puts 'Введите название станции'
    name = gets.chomp
    stations << Station.new(name)

  when 2 # Создать поезд
    puts 'Введите номер поезда'
    number = gets.chomp
    puts 'Выберите тип поезда: 1 - грузовой поезд, 2 - пассажирский'
    type = gets.chomp.to_i
    case type
    when 1
      trains << CargoTrain.new(number)
      puts "Создан грузовой поезд №#{number}"
    when 2
      trains << PassengerTrain.new(number)
      puts "Создан пассажирский поезд №#{number}"
    else
      puts 'Поезд не был создан, вы неверно указали параметры'
    end

  when 3 # Прицепить вагон к поезду
    if trains.empty?
      puts 'Создайте поезд'
    else
      puts 'К какому поезду прицепить вагон ?'
      number = gets.chomp
      train = trains.detect {|train| train.number == number}
      if train.nil?
       puts 'Вы ввели номер несуществующего поезда'
     else
       train.attach_car(CAR_TYPES[train.type].new)
       puts "Теперь у поезда №#{train.number} - #{train.cars.count} вагонов"
     end
   end

  when 4 # Отцепить вагон от поезда
    if trains.empty?
      puts 'Создайте поезд'
    else
      puts 'От какого поезда отцепить вагон ?'
      number = gets.chomp
      train = trains.detect{ |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      elsif train.cars.empty?
        puts 'У этого поезда нет вагонов'
      else
        train.detach_car(train.cars.last)
        puts "Теперь у поезда №#{train.number} - #{train.cars.count} вагонов"
      end
    end

  when 5 # Поместить поезд на станцию
    if trains.empty?
      puts 'Создайте поезд'
    elsif stations.empty?
      puts 'Сначала необходимо создать станцию'
    else
      puts 'Введите номер поезда'
      number = gets.chomp
      train = trains.detect { |train| train.number == number }
      if train.nil?
        puts 'Поезда с таким номером нет'
      else
        puts 'Введите название станции, на которую нужно переместить поезд'
        name = gets.chomp
        station = stations.detect { |station| station.name == name }
        if station.nil?
          puts 'Такой станции нет'
        else
          station.get_train(train)
        end
      end
    end

  when 6 # Просмотреть список станций
    puts 'Список станций'
    stations.each { |station| puts station.name }

  when 7 # Просмотреть список поездов на станции
      if stations.empty?
        puts 'Сначала необходимо создать станцию'
      else
        puts 'Введите название станции'
        name = gets.chomp
        station = stations.detect{ |station| station.name == name }
        if station.nil?
          puts 'Такой станции нет'
        else
          station.show_trains
        end
      end
    else
      puts 'Выбирайте из предложенных вариантов !!!'
    end
  end
