class GameOfLife
  attr_accessor :area
  def initialize(size)
    @area = Array.new(size){Array.new(size) {Cell.new}}
    @size = size
  end

  def rule_will_it_survive(y, x)
    alive_count_near_by(y, x) < 2 ? false : true
  end

  def rule_will_it_remain(y, x)
    count = alive_count_near_by(y, x)
    cell = @area[y][x]
    if(count > 1 && count < 4)
      cell.next_alive = true
      true
    else
      cell.next_alive = false
      false
    end
  end

  def rule_will_it_replicate(y, x)
    cell = @area[y][x]
    if(!cell.alive && alive_count_near_by(y, x) == 3)
      cell.next_alive = true
      true
    else
      cell.next_alive = false
      false
    end
  end

  def start_next_generation
    @area.each_with_index { |y, i| check_cell_next_gen_rules(y, i)}
    @area.each {|y| set_cell_next_generation(y)}
  end

  def alive_cells_in_area
    alive = []
    @area.each_with_index do |y, i|
      y.each_with_index do |x, j|
        if(@area[i][j].alive == true)
          alive << [i, j]
        end
      end
    end
    alive
  end

  def alive_count_near_by(y, x)
    coordinates_near_by = [
      [-1,-1],[-1, 0],[-1, 1],
      [ 0,-1],        [ 0, 1],
      [ 1,-1],[ 1, 0],[ 1, 1]
    ]

    alive_count = 0
    coordinates_near_by.each do |c|
      x_coordinate = c[1] + x
      y_coordinate = c[0] + y

      next if is_outside_area?(y_coordinate, x_coordinate)
      cell = @area[y_coordinate][x_coordinate]
      alive_count += 1  if is_valid_cell?(cell)
    end
    alive_count
  end

  def start
    system "clear" or system "cls"
    1000.times do 
      @area.each do |y|
        puts ""
        y.each do |x| 
          print x.alive ? "{-}" : "   "
        end
      end
      sleep 0.5
      system "clear" or system "cls"
      start_next_generation
    end
  end

  private

  def is_valid_cell?(cell)
    cell && cell.alive
  end

  def is_outside_area?(y, x)
    x < 0 || y < 0 || x >= @size || y >= @size
  end

  def set_cell_next_generation(y)
    y.each do |x|
      x.set_state if(x.alive)
      if(x.next_alive)
        x.set_state
        x.next_alive = false
      end
    end
  end

  def check_cell_next_gen_rules(y, i)
    y.each_with_index do |x, j|
      if(x.alive)
        if(rule_will_it_survive(i, j))
          rule_will_it_remain(i, j)
        end
      else
        rule_will_it_replicate(i, j)
      end
    end
  end
end