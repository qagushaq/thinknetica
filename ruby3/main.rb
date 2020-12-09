require_relative "station"
require_relative "route"
require_relative "train"

station_minsk = Station.new("Минск")
station_brest = Station.new("Брест")
station_bitebsk = Station.new("Витебск")
station_grodno = Station.new("Гродно")
station_gomel = Station.new("Гомель")

route_minsk_brest = Route.new(station_minsk, station_brest)
route_minsk_brest.add_station(station_bitebsk)
route_minsk_brest.add_station(station_gomel)
route_minsk_brest.show_stations

route_minsk_brest.delete_station(station_minsk)
route_minsk_brest.delete_station(station_brest)
route_minsk_brest.delete_station(station_bitebsk)
route_minsk_brest.show_stations

train1 = Train.new(1, 1, 150)
train2 = Train.new(2, 0, 16)
train3 = Train.new(3, 1, 100)
train4 = Train.new(4, 0, 10)
train5 = Train.new(5, 1, 120)

train1.get_route(route_minsk_brest)
train1.move_to(station_brest)
train1.move_to(station_gomel)

train2.get_route(route_minsk_brest)
train2.move_to(station_gomel)

station_gomel.show_trains(0)
station_gomel.show_trains(1)

train1.move_to(station_gomel)
train1.move_to(station_brest)

station_gomel.get_train(train3)
station_gomel.get_train(train4)
station_gomel.get_train(train5)

train1.stations_info
train2.stations_info
