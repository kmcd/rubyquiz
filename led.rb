LED_DIGITS = [
%Q{
 -  
| | 
    
| | 
 -  
},
%Q{
    
  | 
    
  | 
    
},
%Q{
 -  
  | 
 -  
|  
 -  
},
%Q{
 -  
  | 
 -  
  | 
 -  
},
%Q{
    
| | 
 -  
  | 
    
},
%Q{
 -  
|   
 -  
  | 
 -  
},
%Q{
 -  
|   
 -  
| | 
 -  
},
%Q{
 -  
  | 
    
  | 
   
},
%Q{
 -  
| | 
 -  
| | 
 -  
},
%Q{
 -  
| | 
 -  
  | 
 -  
}                                                                                          
]


def expand(digit, multiplier=2)
  led_number = LED_DIGITS[ digit.to_i ].dup
  
  led_number.gsub! /-/, '-' * multiplier
  
  padding = multiplier - 1
  led_number.gsub! /(\s\|)\s$/, (" " * padding ) + '\1 '
  led_number.gsub! /(^.*\|+.*$)/, ('\1' + "\n") * multiplier
  led_number.gsub! /^$\n/, ''
  
  led_number
end

if __FILE__ == $0
  require ' optparse '
  options = { :size => 2 }
  number = ARGV.pop
  ARGV.options do |opts|
    script_name = File.basename($0)
    opts.banner = "Usage: ruby #{script_name} [options] number"
    opts.separator ""
    opts.on("-s", "-size size", Numeric,
      "Specify the size of line segments.",
      "Default: 2"
    ) { |options[:size]| }
    opts.separator ""
    opts.on("-h", "-help", "Show this help message.") { puts opts; exit }
    opts.parse!
  end
else
  # Take in multiplier from -s arg
  led_size = 2
  numbers_to_display = "12"
  
  @led_numbers = numbers_to_display.split(//).inject([]) do |display, number|
    display << expand(number, led_size)
  end
end
