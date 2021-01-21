class TicTacToe
    def initialize(board = nil)
      @board = board || Array.new(9, " ")
    end
  
    def current_player
      turn_count % 2 == 0 ? "X" : "O"
    end
  
    def turn_count
      @board.count{|token| token == "X" || token == "O"}
    end
  
    def display_board
      puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
      puts "-----------"
      puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
      puts "-----------"
      puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    WIN_COMBINATIONS = [
        [0,1,2], 
        [3,4,5], 
        [6,7,8],
        [2,4,6],
        [0,4,8],
        [0,3,6],
        [1,4,7],
        [2,5,8]
      ]

    def input_to_index(input)
        return input.to_i - 1
    end

    def move(index, current_player)
        @board[index] = current_player
    end

    def play
        while !over?
          turn
        end
        if draw?
          puts "Cat's Game!"
        else
          puts "Congratulations #{winner}!"
        end
    end

    def position_taken?(index)
        return cell_taken?(@board[index])
    end

    def cell_taken?(cell)
        return !(cell.nil? || cell == " ")
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn
        puts "Please enter 1-9:"
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(index)
          move(index, current_player)
          display_board
        else
          turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |comb|
        if (@board[comb[0]] == "X" && @board[comb[1]] == "X" && @board[comb[2]] == "X") ||
           (@board[comb[0]] == "O" && @board[comb[1]] == "O" && @board[comb[2]] == "O")
          return comb;
        end
      end
      return false;
    end

    def full?
        @board.each do |cell|
          if !cell_taken?(cell)
            return false
          end
        end
        return true
    end

    def draw?
        return !won? && full?
    end

    def over?
        return won? || draw?
    end
      
    def winner
        winningCombination = won?
        if !winningCombination
          return nil
        else
          # winningCombination = [1,4,7] for example
          return @board[winningCombination[0]];
        end
      end
      
  end 