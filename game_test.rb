require 'minitest/autorun'
require_relative 'game'

class GameTest < MiniTest::Unit::TestCase
  def test_neighbors
    game = Game.new(5,5,[])
    neighbors = game.neighbors(0,0)
    assert_equal 3, neighbors.size
  end

  def test_tick
    size = 20
    game = Game.new(size, size, [[5,5],[5,6],[5,7]])

    game.tick
    state = Array.new
    game.each_cell do |cell, r, c|
      if cell.alive?
        state << [r,c]
      end
    end
    assert_equal [[4, 6], [5, 6], [6, 6]], state
  end
end
