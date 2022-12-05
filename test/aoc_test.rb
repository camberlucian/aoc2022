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
end