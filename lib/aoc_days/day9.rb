def rope1(data)
    head_location = [0,0]
    tail_location = [0,0]
    tail_spots = [[0,0]]
    data.each do |row|
        command = row.split(" ")
        head_location, tail_location, tail_spots = move_head(head_location, tail_location, tail_spots, command[0], command[1].to_i)
    end
    tail_spots.size
end

def move_head(head_location, tail_location, tail_spots, direction, spaces)
    i = 0
    while i < spaces
        head_location = move(head_location, direction)
        if !check_tail(tail_location, head_location)
            new_location = adjust_tail(tail_location, head_location, direction)
            tail_spots << "#{new_location[0]}#{new_location[1]}"
            tail_location = new_location
        end
        i += 1
    end
    return head_location, tail_location, tail_spots.uniq
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