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

def crates1(data)
  crate_set = build_crate_set(data).reverse
  moveset = get_moveset(data)
  sorted_set = sort_crates(crate_set, moveset)
  answer = get_answer(sorted_set)
  answer
end

def crates2(data)
  crate_set = build_crate_set(data).reverse
  moveset = get_moveset(data)
  sorted_set = sort_crates2(crate_set, moveset)
  answer = get_answer(sorted_set)
  answer
end

def get_answer(crates)
  width = crates[crates.size-1].size
  i = 0
  answer = ""
  while i < width
    char_index = find_empty_spot(crates, i)-1
    answer_char = crates[char_index][i]
    answer = answer + answer_char
    i += 1
  end
  answer
end


def sort_crates(crates, moves)
  moves.each do |move|
    target = move[2]-1
    origin = move[1]-1
    number = move[0]
    crates = move_crates(crates, target, origin, number)
  end
  crates
end

def sort_crates2(crates, moves)
  moves.each do |move|
    target = move[2]-1
    origin = move[1]-1
    number = move[0]
    crates = move_crates2(crates, target, origin, number)
  end
  crates
end

def move_crates(crates, target, origin, number)
  i = 0
  while i < number
    crates = move_crate(crates, origin, target)
    i += 1
  end
  crates
end

def move_crates2(crates, target, origin, number)
  width = crates[crates.size-1].size
  origin_layer = find_empty_spot(crates, origin)-1
  payload = []
  i = 0
  while i < number
    crate = crates[origin_layer-i][origin]
    payload << crate
    crates[origin_layer-i][origin] = "%"
    i += 1
  end
  payload = payload.reverse
  target_layer = find_empty_spot(crates, target)
  payload.each do |crate|
    if crates[target_layer].nil?
      crates = crates << Array.new(width, "%")
    end
    crates[target_layer][target] = crate
    target_layer += 1
  end
  crates
end

def move_crate(crates, origin, target)
  width = crates[crates.size-1].size
  origin_layer = find_empty_spot(crates, origin)-1
  crate = crates[origin_layer][origin]
  crates[origin_layer][origin] = "%"
  target_layer = find_empty_spot(crates, target)
  if crates[target_layer].nil?
    crates = crates << Array.new(width, "%")
  end
  crates[target_layer][target] = crate
  crates
end

def find_empty_spot(crates, target)
  crate_layer = nil
  i = 0
  while crate_layer == nil
    if crates[i].nil?
      crate_layer = i
    elsif crates[i][target] == "%"
      crate_layer = i
    else
      i += 1
    end
  end
  crate_layer
end



def get_moveset(data)
  moves = []
  split_index = data.find_index("")+1
  move_data = data[split_index..]
  move_data.each do |line|
    strings = line.split(" ")
    move = []
    strings.each do |string|
      if string.is_integer?
        move << string.to_i
      end
    end
    moves << move
  end
  moves
end

def build_crate_set(data)
  lines = []
  crates = []
  data.each do |line|
    if line[0..3].include?("1")
      break
    else
      lines << line
    end
  end
  lines.each do |line|
    crate = string_chomp(line)
    crates << crate 
  end
  crates
end

def string_chomp(line)
  layer = []
  while line.size > 2 do
    substring = line[0..2]
    if substring.blank?
      layer << "%"
    else
      layer << substring.tr("[]", "")
    end
    line = line[4..]
    if line == nil
      break
    end
  end
  layer
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
