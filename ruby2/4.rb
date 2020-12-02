#Заполнить хеш гласными буквами,где значением будет являтся порядковый номер буквы в алфавите (a - 1).s
alphabet = 'абвгдеёжзийклмнопрстуфхцчшщъыьэюя'
vowels = 'аеёиоуыэюя'
hash_of_vowels = {}
vowels.each_char do |vowel|
  hash_of_vowels[vowel] = alphabet.index(vowel) + 1
end
hash_of_vowels.each do |key,index|
  puts "#{key}-#{index}"
end
