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
end