

WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
    ]

    def won?(board)
        WIN_COMBINATIONS.each do |win_combiantion|
          win_index_1 = win_combiantion[0]
          win_index_2 = win_combiantion[1]
          win_index_3 = win_combiantion[2]
      
          position_1 = board[win_index_1]
          position_2 = board[win_index_2]
          position_3 = board[win_index_3]
      
          if position_1 == "X" && position_2 == "X" && position_3 == "X"
            return win_combiantion 
          else false
          end
      
          if position_1 ==  "O" && position_2 == "O" && position_3 == "O"
            return win_combiantion
          else false
          end
        end
        return nil
      end
      
      def full?(board)
        board.all? {|cell| cell == "X" || cell == "O"}
      end
      
      def draw?(board)
        if (full?(board))
        if !won?(board) && full?(board)
          return true
        elsif !won?(board) && !full?(board)
          return false
        else won?(board)
          return false
        end
    end
      end
      
      def over?(board)
        if draw?(board) || won?(board) || full?(board)
          return true
        else false
        end
      end
      
      def winner(board)
        if won?(board)
           return board[won?(board)[0]]
        else 
          return nil
        end
      end
      

      def input_to_index(user_input)
        user_input.to_i - 1
      end
      
      def move(board, index, current_player)
        board[index] = current_player
      end
      
      def position_taken?(board, location)
        board[location] != " " && board[location] != ""
      end
      
      def valid_move?(board, index)
        index.between?(0,8) && !position_taken?(board, index)
      end
      
      def turn(board)
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(board, index)
          move(board, index, current_player(board))
          display_board(board)
        else
          turn(board)
        end
      end

      def play(board)
        turn(board) until over?(board)
        if(won?(board))
            puts "Congratulations #{winner(board)}!"
        elsif draw?(board)
            puts "Cat's Game!"   
      end 
    end


      def display_board(board)
        puts " #{board[0]} | #{board[1]} | #{board[2]} "
        puts "-----------"
        puts " #{board[3]} | #{board[4]} | #{board[5]} "
        puts "-----------"
        puts " #{board[6]} | #{board[7]} | #{board[8]} "
      end

      def turn_count(board)
        counter = 0
            board.each do |character|
                if (character == "X" || character == "O")
                    counter += 1
                end
            end
            return counter
        end
    
        def current_player(board)
            number_of_turns = turn_count(board)
            if(number_of_turns % 2 == 0)
                return "X"
            end
            return "O"
        end