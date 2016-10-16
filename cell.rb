class Cell
  def initialize(alive)
    @alive = alive
  end

  def live_life(neighbors)
    @next_life = case
                 when alive? && (alive(neighbors) < 2 || alive(neighbors) > 3)
                   false
                 when alive? && (alive(neighbors) == 2 || alive(neighbors) == 3)
                   true
                 when dead? && alive(neighbors) == 3
                   true
                 else
                   false
                 end
  end

  def regenerate
    @alive = @next_life
    @next_life = false
  end

  def next_life?
    @next_life
  end

  def dead?
    @alive == false
  end

  def alive?
    @alive == true
  end

  def alive(neighbors)
    neighbors.map(&:alive?).select{|alive| alive}.size
  end
end
