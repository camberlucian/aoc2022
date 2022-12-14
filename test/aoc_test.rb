# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/aoc_code'

# Test program coolness
class AdventTest < Minitest::Test
  def test_advent_1a
    advent = Advent.new('test_input_1')
    assert_equal advent.advent1a, 75622
  end

  def test_advent_1b
    advent = Advent.new('test_input_1')
    assert_equal advent.advent1b, 213159
  end

  def test_advent_2a
    advent = Advent.new('test_input_2')
    assert_equal advent.advent2a, 13446
  end

  def test_advent_2b
    advent = Advent.new('test_input_2')
    assert_equal advent.advent2b, 13509
  end

  def test_advent_3a
    advent = Advent.new('test_input_3')
    assert_equal advent.advent3a, 7824
  end

  def test_advent_3b
    advent = Advent.new('test_input_3')
    assert_equal advent.advent3b, 2798
  end

  def test_advent_4a
    advent = Advent.new('test_input_4')
    assert_equal advent.advent4a, 569
  end

  def test_advent_4b
    advent = Advent.new('test_input_4')
    assert_equal advent.advent4b, 936
  end

  def test_advent_5a
    advent = Advent.new('test_input_5')
    assert_equal advent.advent5a, "WHTLRMZRC"
  end

  def test_advent_5b
    advent = Advent.new('test_input_5')
    assert_equal advent.advent5b, "GMPMLWNMG"
  end

  def test_advent_6a
    advent = Advent.new('test_input_6')
    assert_equal advent.advent6a, 1175
  end

  def test_advent_6b
    advent = Advent.new('test_input_6')
    assert_equal advent.advent6b, 3217
  end

  # def test_advent_7a
  #   advent = Advent.new('test_input_7')
  #   assert_equal advent.advent7a, 1281698
  # end

  def test_advent_8a
    advent = Advent.new('test_input_8')
    assert_equal advent.advent8a, 3456
  end
end