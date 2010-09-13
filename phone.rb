class String
  def to_phone_keypad
    downcase.split(//).map do |char|
      case char
        when 'a'..'c' : 2
        when 'd'..'f' : 3
        when 'g'..'i' : 4
        when 'j'..'l' : 5
        when 'm'..'o' : 6
        when 'p'..'s' : 7
        when 't'..'v' : 8
        when 'x'..'z' : 9
      end.to_s
    end.join
  end
end

require 'set'
@combinations = Hash.new {|hash,key| hash[key] = Set.new }

File.foreach('/usr/share/dict/words') do |word|
  word.strip!.gsub!(/\'/,'')
  next if word.length > 7
  @combinations[word.to_phone_keypad] << word.downcase.chomp
end

# Split number into possible words (ngrams)
# 123456 => dict[1], dict[12], dict[13] ...