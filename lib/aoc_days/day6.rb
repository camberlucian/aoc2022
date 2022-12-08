def signal1(data)
    line = data.first
    count = 4
    i = 0
    j = 3
    while dupes(line[i..j]) > 0
        count += 1
        i += 1
        j += 1
    end
    count
end

def signal2(data)
    line = data.first
    count = 14
    i = 0
    j = 13
    while dupes(line[i..j]) > 0
        count += 1
        i += 1
        j += 1
    end
    count
end

def dupes(string)
    string.chars.uniq.count { |char| string.count(char) > 1 }
end