def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS =
  [ [0, 1, 2], # across
    [3, 4, 5],
    [6, 7, 8],

    [0, 3, 6], # down
    [1, 4, 7],
    [2, 5, 8],

    [0, 4, 8], # diag
    [2, 4, 6]
  ]

def won?(board)
  WIN_COMBINATIONS.each do |combination|
    return combination if combination.all? { |i| board[i] == 'X' }\
                       || combination.all? { |i| board[i] == 'O'}
  end
  return false
end

def full?(board)
  board.select { |cell| cell == 'X' || cell == 'O'}.length >= 8
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board)
end

def winner(board)
  win_row = won? board
  board[win_row.first] if win_row
end

def turn_count(board)
    board.count { |cell| cell == 'X' || cell == 'O' }
end

def current_player(board)
    turn_count(board) % 2 == 0 ? 'X' : 'O'
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
    if valid_move?(board, index)
        move(board, index, current_player(board)) 
        display_board board
    else
        turn(board)
    end
end

def play(board)
    while !over?(board) do
        turn(board)
        break if draw?(board)
    end

    if won?(board)
        puts "Congratulations %s!" % winner(board)
    elsif draw?(board)
        puts "Cat's Game!"
    end
end
