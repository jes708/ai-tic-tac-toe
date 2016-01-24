WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # Downward diagonal
  [6,4,2]  # Upward diagonal
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, character = "X")
  board[(location.to_i - 1)] = character
end

def position_taken?(board, position)
  !((board[position] == " ") || (board[position] == "") || (board[position] == nil))
end

def valid_move? (board, position)
  position = position.to_i - 1
  (position.between?(0,8)) && (position_taken?(board, position) == false)
end

def turn_count(board)
  counter = 0
  board.each do |space|
    if (space == "X") || (space == "O") 
      counter += 1
    end
  end
  return counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def turn(board)
  loop do 
    puts "Please enter 1-9:"
    position = gets.strip
    if valid_move?(board, position)
      move(board, position, current_player(board))
      display_board(board)
      break  
    else 
      puts "Invalid position"
    end
  end
end

def won?(board)
  win_combination = []
  WIN_COMBINATIONS.each do |line|
    if line.all? { |pos| board[pos] == "X" }
      win_combination = line
    end
    if line.all? { |pos| board[pos] == "O" }
      win_combination = line
    end
  end
  if win_combination != []
    win_combination
  else
    false
  end
end

def full?(board)
  [*0..(board.length - 1)].all? do |location|
    position_taken?(board, location)
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  end
  if draw?(board)
    puts("Cats Game!")
  end
end