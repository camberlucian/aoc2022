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


  end

def open_file(path)
  file_path = File.join(File.dirname(__FILE__), path)
  file = File.open(file_path)
  file_data = file.readlines.map(&:chomp)
  file_data
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
  
