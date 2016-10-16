require 'minitest/autorun'
require_relative 'game'

class CellTest < MiniTest::Unit::TestCase
  def test_dead_cell
    neighbors = []

    c = Cell.new(false)
    refute c.alive?, 'should start dead'
    refute c.next_life?, 'next_life start false'

    assert_equal 0, c.alive(neighbors)

    c.live_life(neighbors)
    refute c.next_life?, 'next_life should be false with 0 neighbors'
    refute c.alive?, 'alive should be false with 0 neighbors'

    c.regenerate
    refute c.alive?, 'alive should still be false after regenerate with 0 neighbors'
    refute c.next_life?, 'next_life should always be false after regenerate'
  end

  def test_live_cell
    neighbors = []

    c = Cell.new(true)
    assert c.alive?, 'should start alive'
    refute c.next_life?, 'next_life start false'

    assert_equal 0, c.alive(neighbors)

    c.live_life(neighbors)
    refute c.next_life?, 'next_life should be false with 0 neighbors'
    assert c.alive?, 'should still be alive before regenerate with 0 neighbors'

    c.regenerate
    refute c.alive?, 'alive should be false after regenerate with 0 neighbors'
    refute c.next_life?, 'next_life should always be false after regenerate'

    c = Cell.new(true)
    assert c.alive?, 'should start alive'

    neighbors << Cell.new(true)
    assert_equal 1, c.alive(neighbors)

    c.live_life(neighbors)
    refute c.next_life?, 'next_life should be false with 1 neighbors'
    assert c.alive?, 'alive should be true before regenerate with 1 neighbors'

    c.regenerate
    refute c.alive?, 'alive should still be false after regenerate with 1 neighbors'
    refute c.next_life?, 'next_life should always be false after regenerate'

    c = Cell.new(true)
    assert c.alive?, 'should start alive'

    neighbors << Cell.new(true)
    assert_equal 2, c.alive(neighbors)

    c.live_life(neighbors)
    assert c.next_life?, 'next_life should be true with 2 neighbors'
    assert c.alive?, 'alive should still be true before regenerate with 2 neighbors'

    c.regenerate
    assert c.alive?, 'alive should now be true after regenerate with 2 neighbors'
    refute c.next_life?, 'next_life should always be false after regenerate'

    c = Cell.new(true)
    assert c.alive?, 'should start alive'

    neighbors << Cell.new(true)
    assert_equal 3, c.alive(neighbors)

    c.live_life(neighbors)
    assert c.next_life?, 'next_life should be true with 3 neighbors'
    assert c.alive?, 'alive should be true before regenerate with 3 neighbors'

    c.regenerate
    assert c.alive?, 'alive should still be false after regenerate with 3 neighbors'
    refute c.next_life?, 'next_life should always be false after regenerate'

    c = Cell.new(true)
    assert c.alive?, 'should start alive'

    neighbors << Cell.new(true)
    assert_equal 4, c.alive(neighbors)

    c.live_life(neighbors)
    refute c.next_life?, 'next_life should be false with 4 neighbors'
    assert c.alive?, 'alive should be true before regenerate with 4 neighbors'

    c.regenerate
    refute c.alive?, 'alive should still be false after regenerate with 4 neighbors'
    refute c.next_life?, 'next_life should always be false after regenerate'
   end
end
