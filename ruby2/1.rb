month {january: 31,
  february: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  august: 31,
  september: 30,
  october: 31,
  november: 30,
  december: 31}

month.each do |key,value|
  if value == 30    #puts key if value == 30 по стайл-гайду можно так писать ?
    puts key
  end
end
