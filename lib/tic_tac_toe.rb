WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board)
    while (turn_count(board) < 9 && !over?(board))
        turn(board)

    end
    if draw?(board)
        puts "Cat's Game!"
        return
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
        return
    end
end

def turn(board)
    puts "Where would you like to go?"
    input = gets.strip
    index = input_to_index(input)
    if !valid_move?(board, index)
        turn(board)
    end
    move(board, index, current_player(board))
    display_board(board)
end

def move(board, index, player)
    board[index] = player
end

def input_to_index(input)
    input.to_i - 1
end

def position_taken?(board, index)
    if (board[index] == " " || board[index] == "" || board[index] == nil)
        return false
    end
    return true
end
def valid_move?(board, index)
    if !position_taken?(board, index)
        if index.between?(0, 8)
            return true
        end
    end
    return false
end

def current_player(board)
    if (turn_count(board) % 2 == 0) 
        return 'X'
    end
    return 'O'
end

def turn_count(board)
    count = 0
    board.each { |n|
        if (n == 'X' || n == 'O')
            count += 1
        end
    }
    return count
end

def full?(board)
    count = 0
    board.each { |n|
        if (n == 'X' || n == 'O')
            count += 1
        end
    }
    if (count == 9)
        return true
    else
        return false
    end
end

def over?(board)
    if (won?(board) || draw?(board))
        return true
    end
    return false
end

def won?(board)
    if winner(board) == nil
        return false
    end
    return true
end

def draw?(board)
    if full?(board) && won?(board) == false
        return true
    else
        return false
    end
end

def winner(board)
    WIN_COMBINATIONS.each { |combination|
    win_index_1 = combination[0]
    win_index_2 = combination[1]
    win_index_3 = combination[2]

    pos1 = board[win_index_1]
    pos2 = board[win_index_2]
    pos3 = board[win_index_3]

    if (pos1 == 'X' && pos2 == 'X' && pos3 == 'X') || (pos1 == 'O' && pos2 == 'O' && pos3 == 'O') then
        return pos1
    end
    }
    return nil
end