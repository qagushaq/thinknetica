module Kernel # translit

  def учше
    exit
  end

  def method_missing(method_name, *arguments, &block)
    return(super) unless contains_russian_letters?(method_name.to_s)
    possible_meaning = translit(method_name.to_s)
    send(possible_meaning, *arguments)
  end

  private

  def translit(string)
    string.chars.map do |char|
      russian_to_english_mapping[char] || char
    end.join
  end

  def contains_russian_letters?(string)
    !(string.chars & russian_symbols).empty?
  end

  def russian_symbols
    "йцукенгшщзхъфывапролджэячсмитьбю".chars
  end

  def russian_to_english_mapping
    english = "qwertyuiop[]asdfghjkl;'zxcvbnm,.".chars
    russian_symbols.zip(english).to_h
  end
end
