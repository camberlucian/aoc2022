class String
    def is_integer?
      self.to_i.to_s == self
    end
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