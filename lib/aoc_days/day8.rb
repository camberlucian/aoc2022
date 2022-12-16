def trees1(data)
    tree_grid = grid_trees(data)
    width = tree_grid[0].size
    height = tree_grid.size
    results = count_visible_trees(tree_grid)
    results[0]
end

def trees2(data)
    tree_grid = grid_trees(data)
    best_score(tree_grid)
    # score = calculate_tree_score(tree_grid, 3, 2, 5, 5)
    # score
end

def best_score(trees)
    score = 0
    trees.each_with_index do |row, index|
        row_score = score_row(trees, index)
        if row_score > score
            score = row_score
        end
    end
    score
end

def score_row(trees, index)
    score = 0
    row = trees[index]
    row.each_with_index do |tree, tree_index|
        tree_score = score_tree(trees, index, tree_index, tree, row.size)
        if tree_score > score
            score = tree_score
        end
    end 
    score
end

def score_tree(trees, row_index, tree_index, tree_height, row_size)
    if row_index == 0
        0
    elsif row_index == trees.size-1
        0
    elsif tree_index == 0
        0
    elsif tree_index == row_size-1
        0
    else
        calculate_tree_score(trees, row_index, tree_index, tree_height, row_size)
    end
end

def calculate_tree_score(grid, row_index, tree_index, tree_height, row_size)

    right_score = count_horizontal(grid[row_index][tree_index+1..row_size], tree_height, tree_index, row_size)
    left_score = count_horizontal(grid[row_index][0..tree_index-1].reverse, tree_height, tree_index, row_size)
    top_score = count_vertical(grid[0..row_index-1].reverse, tree_index, tree_height, row_index)
    bottom_score = count_vertical(grid[row_index+1..grid.size], tree_index, tree_height, row_index)
    (right_score * left_score * top_score * bottom_score)
end

def count_horizontal(trees, height, tree_index, row_size)
    score = 0
    trees.each do |tree|
        if tree >= height
            score += 1
            break
        else
            score += 1
        end
    end
    score
end

def count_vertical(trees, tree_index, height, row_index)
    score = 0
    trees.each do |row|
        if row[tree_index] >= height
            score += 1
            break
        else
            score += 1
        end
    end
    score
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
    edge_count = 0
    grid.each_with_index do |row, index|
        results = count_tree_row(grid, index)
        count += results[0]
        edge_count += results[1]
    end
    [count, edge_count]
end

def count_tree_row(grid, row_index)
    count = 0
    edge_count = 0
    row = grid[row_index]
    row.each_with_index do |tree_height, tree_index|
        results = check_visible(grid, tree_height, row_index, tree_index, row.size)
        count += results[0]
        edge_count += results[1]
    end
    [count, edge_count]
end

def check_visible(grid, tree_height, row_index, tree_index, row_size)
    if row_index == 0
        [1, 1]
    elsif row_index == grid.size-1
        [1, 1]
    elsif tree_index == 0
        [1, 1]
    elsif tree_index == row_size-1
        [1, 1]
    elsif visible_tree(grid, tree_height, row_index, tree_index, row_size)
        [1, 0]
    else
        [0, 0]
    end
end

def visible_tree(grid, tree_height, row_index, tree_index, row_size)
    # might need to be tree_index -1
    if visible_horizontal(grid[row_index][tree_index+1..row_size], tree_height, tree_index)
        true
    elsif visible_horizontal(grid[row_index][0..tree_index-1], tree_height, tree_index)
        true
    elsif visible_vertical(grid[0..row_index-1], tree_index, tree_height, row_index)
        true
    elsif visible_vertical(grid[row_index+1..grid.size], tree_index, tree_height, row_index)
        true
    else
        false
    end
end

def visible_horizontal(trees, height, tree_index)
    result = true
    trees.each do |tree|
        if tree >= height
            result = false
            break
        end
    end
    result
end

def visible_vertical(trees, tree_index, height, row_index)
    result = true
    trees.each do |row|
        if row[tree_index] >= height
            result = false
            break
        end
    end
    result
end

