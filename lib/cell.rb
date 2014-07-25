class Cell
  attr_accessor :alive, :next_alive
  def initialize
    @alive = false
    @next_alive = false
  end

  def set_state
    @alive = !@alive
  end
end