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
