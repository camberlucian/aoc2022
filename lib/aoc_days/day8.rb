def trees1(data)
    tree_grid = grid_trees(data)
    count_visible_trees(tree_grid)
end

def grid_trees(data)
    trees = []
    data.each do |row|
        trees << row.chars.collect {|x| x.to_i }
    end
    trees
end

def count_visible_trees(grid)
    count = 0
    grid.each_with_index do |row, index|
        count += count_tree_row(grid, index)
    end
    count
end

def count_tree_row(grid, row_index)
    count = 0
    row = grid[row_index]
    row.each_with_index do |tree_height, tree_index|
        count += check_visible(grid, tree_height, row_index, tree_index, row.size)
    end
    count
end

def check_visible(grid, tree_height, row_index, tree_index, row_size)
    if row_index == 0
        1
    elsif row_index == grid.size
        1
    elsif tree_index == 0
        1
    elsif tree_index == row_size
        1
    elsif visible_tree(grid, tree_height, row_index, tree_index, row_size)
        1
    else
        0
    end
end

def visible_tree(grid, tree_height, row_index, tree_index, row_size)
    # might need to be tree_index -1
    if visible_horizontal(grid[row_index][tree_index+1..row_size], tree_height)
        true
    elsif visible_horizontal(grid[row_index][0..tree_index-1], tree_height)
        true
    elsif visible_vertical(grid[0..tree_index-1], tree_index, tree_height)
        true
    elsif visible_vertical(grid[tree_index+1..grid.size], tree_index, tree_height)
        true
    else
        false
    end
end

def visible_horizontal(trees, height)
    result = true
    trees.each do |tree|
        if tree >= height
            result = false
            break
        end
    end
    result
end

def visible_vertical(trees, tree_index, height)
    result = true
    trees.each do |row|
        if row[tree_index] > height
            result = false
            break
        end
    end
    result
end

