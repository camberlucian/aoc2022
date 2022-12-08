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
  