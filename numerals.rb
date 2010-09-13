class Numeric
  def to_eng
    case self
    when 0..19                          : eng
    when 20..99                         : eng(self/10,:irregular)       + 'ty '         + (self % 10).to_eng
    when 100..999                       : eng(self/100)                 + ' hundred '   + (self % 100).to_eng
    when 1000..999_999                  : (self/1000).to_eng            + ' thousand '  + (self % 1000).to_eng
    when 1_000_000..999_999_999         : (self/1_000_000).to_eng       + ' million '   + (self % 1_000_000).to_eng
    when 1_000_000_000..999_999_999_999 : (self/1_000_000_000).to_eng   + ' billion '   + (self % 1_000_000_000).to_eng
    end.                                   
      gsub(/\szero$/,'').
      gsub(/(billion|million|hundred|thousand)\s((\w+ty \w+)|(\w+))$/,'\1 and \2').
      gsub(/(.*)\band\b(.*)\band\b(.*)/,'\1\2 and \3').
      gsub(/\s{2,}/, ' ').
      strip
  end
    
  private
  
  def eng(digit=self,irregular=false)
    text = %w{ zero one two three four five six seven eight nine ten eleven twelve thirteen 
    fourteen fifteen sixteen seventeen eighteen nineteen }[digit]
    
    irregular ? text.gsub(/two/, 'twen').gsub(/three/,'thir').gsub(/five/,'fif') : text
  end
end

if $PROGRAM_NAME == __FILE__
  load __FILE__
  require 'test/unit'
  require 'active_support/testing/declarative'
  require 'active_support'
  
  class NumeralToEnglishTest < Test::Unit::TestCase
    extend ActiveSupport::Testing::Declarative
    
    def english(number, text)
      assert_equal text,  number.to_eng
    end
    
    test "1 to 19" do
      english 0, 'zero'
      english 1, 'one'
      english 11, 'eleven'
      english 12, 'twelve'
      english 13, 'thirteen'
    end
    
    test "20 to 99" do
      english 22, 'twenty two'
      english 37, 'thirty seven'
      english 59, 'fifty nine'
    end
    
    test "100 to 999" do
      english 101, 'one hundred and one'
      english 200, 'two hundred'
      english 439, 'four hundred and thirty nine'
      english 999, 'nine hundred and ninety nine'
    end
    
    test "1000 to 999,900" do
      english 1000,   'one thousand'
      english 1001,   'one thousand and one'
      english 999_999, 'nine hundred ninety nine thousand nine hundred and ninety nine'
    end
  end
end