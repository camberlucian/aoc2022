# frozen_string_literal: true

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

def unit_totals(data)
  unit_total = 0
  totals = []
  data.each_with_index do |n, index|
    case n.to_i
    when 0
      totals << unit_total
      unit_total = 0
    else
      unit_total += n.to_i
      if index == data.size - 1
        totals << unit_total
      end
    end
  end
  totals
end

def top_total(data, range)
  i = 0
  total = 0
  while i < range do
    number = data.max
    total += number
    data.delete_at(data.index(number))
    i += 1
  end
  total
end

def rps(data)
  score = 0
  rules = {"X" => {"beats" => "C", "equals" => "A", "value" => 1},
          "Y" => {"beats" => "A", "equals" => "B", "value" => 2},
          "Z" => {"beats" => "B", "equals" => "C", "value" => 3}}

  data.each do |line|
    inputs = line.split(" ")
    elf = inputs[0]
    player = inputs[1]
    if rules[player]["equals"] == elf
      score += (3 + rules[player]["value"])
    elsif rules[player]["beats"] == elf
      score += (6 + rules[player]["value"])
    else
      score += rules[player]["value"]
    end
  end
  score
end

def rps2(data)
  score = 0
  rules = {"A" => {"X" => 3, "Y" => 4, "Z" => 8},
          "B" => {"X" => 1, "Y" => 5, "Z" => 9},
          "C" => {"X" => 2, "Y" => 6, "Z" => 7}}

  data.each do |line|
    inputs = line.split(" ")
    elf = inputs[0]
    player = inputs[1]
    score += rules[elf][player]
  end
  score
end

def packs1(data)
  chart = build_chart()
  score = 0
  data.each do |line|
    range = line.size/2
    pouch1 = line[0..range-1]
    pouch2 = line[range..]
    item = pack_value(pouch1, pouch2)
    score += chart[item]
  end
  score
end

def packs2(data)
  score = 0
  chart = build_chart()
  groups = chunk(data, 3)
  groups.each do |group|
    possible_answers = similar_chars(group[0], group[1])
    badge = pack_value(possible_answers, group[2])
    score += chart[badge]
  end
  score
end

def pairs1(data)
  score = 0
  pair_sets = parse_pairs(data)
  pair_sets.each do |pair|
    if pair[0][0] < pair[1][0]
      if pair[0][1] >= pair[1][1]
        score += 1
      end
    elsif pair[1][0] < pair[0][0]
      if pair[1][1] >= pair[0][1]
        score += 1
      end
    else
      score += 1
    end
  end
  score
end

def pairs2(data)
  score = 0
  pair_sets = parse_pairs(data)
  pair_sets.each do |pair|
    a = (pair[0][0]..pair[0][1]).to_a
    b = (pair[1][0]..pair[1][1]).to_a
    if a & b != []
      score +=1
    end
  end
  score
end

def parse_pairs(data)
  pairs = []
  data.each do |line|
    elf_set = []
    pair = line.split(",")
    pair.each do |s|
      elf = s.split("-")
      elf = elf.map { |string| string.to_i}
      elf_set << elf
    end
    pairs << elf_set
  end
  pairs
end

def similar_chars(set1, set2)
  chars = []
  set1.each_char do |x|
    if set2.include?(x)
      chars << x
    end
  end
  chars
end

def chunk(data, groups)
  chunks = []
  group = []
  data.each do |line|
    group << line
    if group.size == groups
      chunks << group
      group = []
    end
  end
  chunks
end

def pack_value(set1, set2)
  i = 0
  character = ""
  found = false
  while !found do
    if set2.include?(set1[i])
      character = set1[i]
      found = true
    end
    i += 1
  end
  character
end

def build_chart()
  table = Hash.new
  i = 1
  lcs = "a"
  ucs = "A"
  while i < 27 do
    table.store(lcs, i)
    i += 1
    lcs = lcs.next
  end
  while i < 53 do
    table.store(ucs, i)
    i += 1
    ucs = ucs.next
  end
  table
end
  
