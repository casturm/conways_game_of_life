require_relative 'cell'

class Game

  attr_reader :generation

  def initialize(rows, cols, seed)
    @grid = populate_soup(rows, cols, seed)
    @generation = 0
  end

  def live_life
    each_cell do |cell, r, c|
      cell.live_life(neighbors(r, c))
    end
  end

  def regenerate
    each_cell do |cell, r, c|
      cell.regenerate
    end
  end

  def tick
    live_life
    regenerate
    @generation = @generation + 1
  end

  def each_row
    @grid.each_with_index do |rows, r|
      yield rows, r
    end
  end

  def each_cell
    each_row do |rows, r|
      rows.each_with_index do |cell, c|
        yield cell, r, c
      end
    end
  end

  def populate_soup(rows, cols, seed)
    grid = Array.new(rows) { Array.new(cols) }
    rows.times do |r|
      cols.times do |c|
        grid[r][c] = Cell.new(seed.include?([r,c]))
      end
    end
    grid
  end

  def neighbors(r, c)
    [cell_at(r, c-1),
     cell_at(r, c+1),
     cell_at(r-1, c-1),
     cell_at(r-1, c),
     cell_at(r-1, c+1),
     cell_at(r+1, c-1),
     cell_at(r+1, c),
     cell_at(r+1, c+1)
    ].select do |cell|
      !cell.nil?
    end
  end

  def cell_at(r, c)
    if r > -1 && r < (@grid.size - 1) && c > -1 && c < (@grid.size - 1)
      @grid[r][c]
    end
  end
end
