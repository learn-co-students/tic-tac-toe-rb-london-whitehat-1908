WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5],  # Middle row
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [6,4,2]
  # ETC, an array for each win combination
]

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def winner(board)
  winningCondition = won?(board)
  if (winningCondition != false)
    board[winningCondition[0]]
  end
end


def won?(board)
  WIN_COMBINATIONS.each do |win|
    if (board[win[0]] == board[win[1]]) && (board[win[1]] == board[win[2]]) && (board[win[0]] != " ") && (board[win[0]] != "")
      return (win)
    end
  end
  return false
end


def draw?(board)
  (full?(board) && !won?(board))
end


def full?(board)
  board.each do |item|
    if !((item == "X") || (item == "O"))
      return false
    end
  end
  true
end


def over?(board)
  return(won?(board) || draw?(board))
end


def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts '-----------'
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts '-----------'
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def valid_move?(board, index)
  index.between?(0, 8) && !position_taken?(board, index)
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def turn(board)
  puts 'Please enter 1-9:'
  user_input = gets.strip
  index = input_to_index(user_input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def position_taken?(board, index)
  board[index] == 'X' || board[index] == 'O'
end

def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end

def turn_count(board)
  board.count { |token| token == 'X' || token == 'O' }
end

def move(board, index, player)
  board[index] = player
end

def winner(board)
  if winning_combo = won?(board)
    board[winning_combo.first]
  end
end
