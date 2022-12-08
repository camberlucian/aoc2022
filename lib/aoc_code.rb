# frozen_string_literal: true

require_relative './aoc_days/day1'
require_relative './aoc_days/day2'
require_relative './aoc_days/day3'
require_relative './aoc_days/day4'
require_relative './aoc_days/day5'



# The coolest program
class Advent
  attr_reader :content
  def initialize(path)
    @content = open_file(path)
  end

  def advent1a
    unit_totals(@content).max
  end

  def advent1b
    totals = unit_totals(@content)
    top_total(totals, 3)
  end

  def advent2a
    rps(@content)
  end

  def advent2b
    rps2(@content)
  end

  def advent3a
    packs1(@content)
  end

  def advent3b
    packs2(@content)
  end

  def advent3b
    packs2(@content)
  end

  def advent4a
    pairs1(@content)
  end

  def advent4b
    pairs2(@content)
  end

  def advent5a
    crates1(@content)
  end

  def advent5b
    crates2(@content)
  end
end

class String
  def is_integer?
    self.to_i.to_s == self
  end
end

def open_file(path)
  begin
    file_path = File.join(File.dirname(__FILE__), path)
    file = File.open(file_path)
    file_data = file.readlines.map(&:chomp)
    file_data
  ensure
    file.close
  end
end