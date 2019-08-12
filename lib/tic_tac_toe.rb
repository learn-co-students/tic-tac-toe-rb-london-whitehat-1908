puts "Welcome to Tic Tac Toe!"
def display_board board
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

board = [" "," "," "," "," "," "," "," "," "]
display_board(board)

def input_to_index (user_input)
    user_input.to_i - 1 
end
  
  def  move (array, index, value)
    array[index] = value
  end

  def position_taken?(board, index)
    if board[index] == " " || board[index] == nil || board[index] == ""
     return false
    elsif board[index] == "X" || board[index] == "O"
     return true
    end
 end

 def valid_move?(board, index)
    if index.between?(0 , 8) && position_taken?(board , index) == false
        return true
    end
    return false
end

def turn(board)
    puts "Please enter 1-9:"
    number = gets.strip
    index = input_to_index (number) 
    if valid_move?(board,index) == false
        turn(board)
    else
        move(board, index, current_player(board)) 
        display_board(board)
    end
end 

  def play (board)
    while !over?(board)
        turn(board)
    end
    if draw?(board)
        puts "Cat's Game!"
    end
    if won?(board)
        puts "Congratulations #{winner(board)}!"
    end
  end

  def turn_count(array)
    count = 0
    array.each { |string| count += 1 if ["X", "O"].include?(string) }
    count
end

def current_player(board)
    numb = turn_count(board)
    if (numb % 2).even?
        return "X"
    else
        return "O"
    end
end

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,4,8],
    [2,4,6],
    [0,3,6],
    [1,4,7],
    [2,5,8]
  ]
  def won? (board)
    WIN_COMBINATIONS.each { |combo| 
      pos1 = board[combo[0]]
      pos2 = board[combo[1]]
      pos3 = board[combo[2]]
    
      if pos1 == "X" && pos2 == "X" && pos3 == "X"
        return combo
      end
      if pos1 == "O" && pos2 == "O" && pos3 == "O"
        return combo
      end
    }
    return nil
    
  end
  
  def winner (board)
    WIN_COMBINATIONS.each { |combos| 
      pos1 = board[combos[0]]
      pos2 = board[combos[1]]
      pos3 = board[combos[2]]
    
      if pos1 == "X" && pos2 == "X" && pos3 == "X"
        return "X"
      end
      if pos1 == "O" && pos2 == "O" && pos3 == "O"
        return "O"
      end
    }
    return nil
  end
  
  def over? (board)
    if draw?(board) || won?(board)
      return true
    end
    return false 
  end 
  
  def draw?(board)
    if full?(board)== true && !won?(board)
      return true
    else
      return false
    end
  end 
  
  def full? (board)
    board.each { |space| 
      if space == " "
        return false
      end 
    }
    return true
  end 
