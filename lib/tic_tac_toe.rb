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

def initialized_board
  [" "] * 9
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

def ai_turn(board, mode)
  case mode
  when 1
    options = [*1..9]
  else
    options = medium(board)
  end
    
    narrowed = (options.reject {|pos| position_taken?(board, (pos - 1))})
    
    if mode == 3
      position = hard(narrowed)
    else
      position = narrowed.sample
    end

    move(board, position, current_player(board))
    puts "Your turn"
    display_board(board)
end

def medium(board)
  options = WIN_COMBINATIONS.select do |line|
    line.one? {|num| board[num] == " "} && ( line.none? {|num| board[num] == "X"} || line.none? {|num| board[num] == "O"} )
  end
  if options.none?
    options = WIN_COMBINATIONS.select do |line|
      line.any? {|num| board[num] == "X"} && line.any? {|num| board[num] == " "}
    end
  end

  options.flatten.map {|el| el + 1}
end

def hard(narrowed)
  if narrowed.include?(5)
    position = 5
  else
    position = (narrowed.select {|el| [1, 3, 7, 9].include?(el)}).sample
  end
  if position.nil?
    position = narrowed.sample
  end
  position
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
  win_combination = WIN_COMBINATIONS.select do |line|
    line.all? { |pos| board[pos] == "X" } || line.all? { |pos| board[pos] == "O" }
  end
  win_combination != [] ? win_combination.flatten : false
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

def difficulty
  loop do
    puts "Choose a mode number:"
    puts "  1: Easy"
    puts "  2: Medium"
    puts "  3: Hard"
    puts "  4: 2-Player"
    mode = gets.strip
    if mode.to_i.between?(1, 4)
      return mode.to_i
    else
      puts "Invalid Input"
    end
  end
end

def play(board, mode)
  until over?(board)
    if mode == 4
      turn(board)
    else
      if current_player(board) == "X"
        turn(board)
      else 
        ai_turn(board, mode)
      end
    end 
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
  play_again
end

def play_mode(board)
  mode = difficulty
  play(board, mode)
end

def play_again
  loop do
    puts("Play again? (Y/N)")
    answer = gets.strip
    if ["yes", "y"].include?(answer.downcase)
      play_mode(initialized_board)
    elsif ["no", "n"].include?(answer.downcase)
      puts "Oh...ok T_T"
      abort
    else
      puts "Was that a yes or a no?"
    end
  end
end