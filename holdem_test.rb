require 'test/unit'
$LOAD_PATH << File.join(File.dirname(__FILE__))
require 'holdem'
require 'rubygems'
require 'active_support/testing/declarative'

class Test::Unit::TestCase
  extend ActiveSupport::Testing::Declarative
  
  # TODO: call directly on String, eg 'foo'.beats 'bar'
  def beats(winner,loser)
    winner, loser = Hand.new(winner), Hand.new(loser)
    assert( winner > loser )
  end
end

class WinningHandsTest < Test::Unit::TestCase
  test "highest card should win if no scoring poker hands" do
    beats '2d 3s 5c 6c Ad', '2c 3d 5s 6h Kd'
  end
  
  test "one pair beats no matches" do
    beats '2d 2s 5c 6c Ad', '2c 3d 5s 6h Kd'
  end
  
  test "high pair beats low pair" do
    beats 'Ad As 5c 6c Jd', 'Kc Kd 5s 6h Qd'
  end
  
  test "highest card wins when pairs are equal" do
    beats 'Ad As 5c 6c Kd', 'Ac Ad 5s 6h Qd'
  end
  
  test "two pair beats a pair" do
    beats 'Ad As 5c 5d Kd', 'Ac Ad 5s 6h Qd'
  end
end