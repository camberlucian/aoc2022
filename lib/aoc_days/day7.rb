def files1(data)
    sys = build_system_hash(data)
    puts("FILES")
    puts(sys.inspect)
    puts("^^^^^^^^^^^^^^")
    total, dirs = total_disposable_memory(sys)
    puts("DIRECTORIES")
    puts(dirs.inspect)
    puts("^^^^^^^^^^^^")
    answer = cullable_dirs(dirs)
end

def cullable_dirs(dirs)
    total = 0
    dirs.each do |key, value|
        if value <= 100000
            total += value
        end
    end
    total
end

def total_disposable_memory(sys, dirs = Hash.new)
    total = 0
    sys.each do |key, value|
        if value.respond_to?(:each)
            dirs[key] = 0
            size, dirs = total_disposable_memory(value, dirs)
            dirs[key] = size
            total += size
        else
            total += value
        end
    end
    return total, dirs
end 


def build_system_hash(data)
    sys = Hash.new
    current_path = ""
    data.each do |line|
        sys, current_path = process_command(sys, line, current_path)
    end
    sys
end

def process_command(sys, line, current_path)
    case line[0..3]
    when "$ cd"
        process_cd(sys, line, current_path)
    when "$ ls"
        return sys, current_path
    when "dir "
        key = line.split(" ")[1]
        parent_key = current_path.split("/")[-1]
        folder = Hash.new
        puts("ADDING NEW DIRECTORY TO CURRENT PATH")
        puts(current_path)
        sys = put_nested_hash_value(sys, parent_key, key, folder)
        return sys, current_path
    else
        size_and_name = line.split(" ")
        key = size_and_name[1] + ".fl"
        value = size_and_name[0].to_i
        puts("ADDING FILE IN CURRENT PATH")
        puts(current_path)
        parent_key = current_path.split("/")[-1]
        sys = put_nested_hash_value(sys, parent_key, key, value)
        return sys, current_path
    end
end

def process_cd(sys, line, current_path)
    dir = line[5..]
    if dir == "/"
        puts("BEGINNING! SHOULD NOT BE HERE MOR THAN ONCE")
        dir = "root"
    end
    if dir == ".."
        current_path = clip_path(current_path)
    else
        if nested_hash_value(sys, dir) == nil
            folder = Hash.new
            if current_path == ""
                sys[dir] = folder
            else
                puts("NAVIGATING DIRECTORY TO CURRENT PATH")
                puts(current_path)
                sys = put_nested_hash_value(sys, current_path[-1], dir, folder)
            end
        end
        current_path = current_path + "/#{dir}"
    end
    return sys, current_path
end

def clip_path(path)
    dirs = path.split("/")
    dirs = dirs.first(dirs.size-1)
    dirs.unshift("/")
    new_path = ""
    dirs.each do |string|
        new_path += (string + "/")
    end
    new_path
end

def nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
        obj[key]
    elsif obj.respond_to?(:each)
        r = nil
        obj.find{ |*a| r=nested_hash_value(a.last,key) }
        r
    end
end

def put_nested_hash_value(obj, parent_key, key, value)
    puts("PUTTING IN NESTED OBJECT")
    puts(obj.inspect)
    puts("PARENT KEY - #{parent_key}")
    puts("KEY - #{key.inspect}")
    puts("VALUE - #{value.inspect}")
    if obj.respond_to?(:key?) && obj.key?(parent_key)
        obj[parent_key][key] = value
    elsif obj.respond_to?(:each)
        obj.each{ |*a| put_nested_hash_value(a.last,parent_key, key, value) }
    end
    obj
end
