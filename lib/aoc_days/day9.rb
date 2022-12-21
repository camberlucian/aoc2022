def rope1(data)
    head_location = [0,0]
    tail_location = [0,0]
    tail_spots = [[0,0]]
    data.each do |row|
        command = row.split(" ")
        head_location, tail_location, tail_spots = move_head(head_location, tail_location, tail_spots, command[0], command[1].to_i)
    end
    tail_spots.uniq.size
end

def rope2(data)
    i = 0
    rope = []
    while i < 10
        rope[i] = [0,0]
        i += 1
    end
    tail_spots = [[0,0]]
    data.each do |row|
        command = row.split(" ")
        rope, tail_spots = move_rope(rope, tail_spots, command[0], command[1].to_i)
    end
    result = tail_spots.uniq
    if result == expected_result()
        puts("THEY ARE EQUAL")
    else
        puts("THEY ARE NOT EQUAL")
        puts(result.inspect)
        puts(expected_result.inspect)
    end
    result.size
end

def expected_result()
    results = [[0, 0], [5, 1], [4, 8], [-3, 7], [-2, 5], [-1, 5], [0, 5], [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [14, 4], [13, -5], [12, -5], [11, -5], [10, -5], [9, -5], [8, -5], [7, -5], [6, -5], [5, -5], [4, -5], [3, -5], [2, -5], [1, -5], [0, -5], [-1, -5], [-2, -5], [-11, -4], [-11, -3], [-11, -2], [-11, -1], [-11, 0], [-11, 1], [-11, 2], [-11, 3], [-11, 4], [-11, 5], [-11, 6]]
    result = []
    results.each do |loc|
        result << "#{loc[0]} #{loc[1]}"
    end
    result
end

def move_rope(rope, tail_spots, direction, spaces)
    head = rope[0]
    i = 0
    original_size = tail_spots.size
    while i < spaces
        head = move(head, direction)
        rope[0] = head
        rope = adjust_rope(rope, direction)
        tail_spots << "#{rope[9][0]} #{rope[9][1]}"
        tail_spots = tail_spots.uniq
        if tail_spots.size > original_size
            puts("NEW TAIL SPOT!! #{rope[9].inspect}")
            original_size = tail_spots.size
        end
        i += 1
    end
    tail_spots = tail_spots.uniq
    if tail_spots.size > original_size
        puts("NEW TAIL SPOT!! #{rope[9].inspect}")
    end
    return rope, tail_spots
end

def adjust_rope(rope, direction)
    head = rope[0]
    tail = rope[0..]
    tail.each_with_index do |knot, index|
        if !check_tail(knot, head)
            new_location = adjust_tail(knot, head, direction)
            rope[index] = new_location
            head = new_location
        end
    end
    rope
end

def move_head(head_location, tail_location, tail_spots, direction, spaces)
    i = 0
    while i < spaces
        head_location = move(head_location, direction)
        if !check_tail(tail_location, head_location)
            new_location = adjust_tail(tail_location, head_location, direction)
            tail_spots << "#{new_location[0]}#{new_location[1]}"
            tail_location = new_location
            puts("HEAD: #{head_location.inspect}, TAIL: #{new_location.inspect}")
        end
        i += 1
    end
    return head_location, tail_location, tail_spots
end

def adjust_tail(tail_location, head_location, direction)
    case direction
    when "R"
        tail_location[0] += 1
        tail_location[1] = head_location[1]
    when "L"
        tail_location[0] -= 1
        tail_location[1] = head_location[1]
    when "U"
        tail_location[1] += 1
        tail_location[0] = head_location[0]
    when "D"
        tail_location[1] -= 1
        tail_location[0] = head_location[0]
    end
    tail_location
end

def move(head_location, direction)
    puts("ORIGINAL HEAD: #{head_location.inspect}")
    case direction
    when "R"
        [head_location[0]+1, head_location[1]]
    when "L"
        [head_location[0]-1, head_location[1]]
    when "U"
        [head_location[0], head_location[1]+1]
    when "D"
        [head_location[0], head_location[1]-1]
    end
end

def check_tail(tail_location, head_location)
    if tail_location[0].between?(head_location[0]-1, head_location[0]+1) && tail_location[1].between?(head_location[1]-1, head_location[1]+1) 
        true
    else
        false
    end
end