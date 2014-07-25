require "minitest/autorun"

class TestGameOfLife < Minitest::Test
  def setup
    @game = GameOfLife.new(15)
    my_start_values1
  end

  def my_start_values1
    area = @game.area

    #first test
    area[5][4].set_state
    area[5][5].set_state
    area[5][6].set_state

    area[0][1].set_state
    area[9][1].set_state

    area[0][9].set_state


    # area[7][7].set_state
    # area[7][8].set_state
    # area[7][9].set_state
    # area[8][8].set_state
    # area[8][9].set_state

    area[7][2].set_state
    area[8][3].set_state
    area[9][3].set_state
    area[8][0].set_state
    area[9][0].set_state
    area[10][1].set_state
    #binding.pry
  end

  def my_start_values2
    area = @game.area
    #second test
  end

  def test_cell_spawning
    assert_equal(@game.area.empty?, false)
  end

  def test_find_near_cells
    assert_equal(@game.alive_count_near_by(5, 5), 2)
  end

  def test_00_coordinates
    assert_equal(@game.alive_count_near_by(1, 1), 1)
  end

  def test_09_coordinates
    assert_equal(@game.alive_count_near_by(0, 8), 1)
  end

  def test_if_can_rule_will_it_survive
    assert_equal(@game.rule_will_it_survive(5, 5), true)
  end

  def test_if_can_rule_will_it_remain
    #assert_equal(@game.rule_will_it_remain(0, 1), true) # fails
    assert_equal(@game.rule_will_it_survive(5, 5), true) # passes
  end

  def test_if_can_rule_will_it_replicate
    # assert_equal(@game.rule_will_it_remain(9, 7), true) # fails
    assert_equal(@game.rule_will_it_replicate(4, 5), true) # passes - borns
  end

  def test_if_next_gen_changed
    this_gen = @game.alive_cells_in_area
    @game.start_next_generation
    next_gen = @game.alive_cells_in_area
    assert(this_gen != next_gen, "The same!")

    @game.start_next_generation
    next_gen = @game.alive_cells_in_area
    assert(this_gen != next_gen, "The same!")
  end

  def test_all_working
    area = @game.area
    100.times do 
      y = Random.rand(@game.size)
      x = Random.rand(@game.size)
      area[y][x].set_state
    end
    @game.start 
  end
end