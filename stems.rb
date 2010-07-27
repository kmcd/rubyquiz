class String
  def normalise
    downcase!
    gsub!('\'','')
    strip!
  end
end

# stems => { 'aeirst' => { 'a'  => ['asteria'], 'b' => ['baiters'] }
# TODO: investigate why Hash.new Hash.new([]) doesn't update correctly
@stems = Hash.new 

File.foreach('/usr/share/dict/words') do |word|
  word.normalise
  next unless word.length == 7
  
  seven_letter_word_letters = word.split(//).sort
  
  seven_letter_word_letters.uniq.each do |letter|
    six_letter_stem = seven_letter_word_letters.join.sub letter, ''
    
    combinations = @stems[six_letter_stem] || {}
    
    if combinations[letter]
      combinations[letter] << word
    else
      combinations[letter] = [word]
    end
    
    @stems[six_letter_stem] = combinations
  end
end

cutoff = 6
