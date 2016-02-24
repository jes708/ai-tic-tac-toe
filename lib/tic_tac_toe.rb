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
  board[location] = character
end

def position_taken?(board, position)
  board[position] != " "
end

def valid_move? (board, position)
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
  mode == 1 ? options = [*0..8] : options = medium(board)
  narrowed = (options.reject {|pos| position_taken?(board, (pos))})
  mode == 3 ? position = hard(narrowed) :position = narrowed.sample
  move(board, position, current_player(board))
  sleep(0.5)
  puts "O is thinking..."
  sleep(1)
  display_board(board)
end

def medium(board)
  options = WIN_COMBINATIONS.select do |line|
    line.one? {|num| board[num] == " "} &&
    (line.none? {|num| board[num] == "X"} || line.none? {|num| board[num] == "O"})
  end
  if options.none?
    options = WIN_COMBINATIONS.select do |line|
      line.any? {|num| board[num] == "X"} && line.any? {|num| board[num] == " "}
    end
  end

  options.flatten
end

def hard(narrowed)
  if narrowed.include?(4)
    position = 4
  else
    position = (narrowed.select {|el| [0, 2, 6, 8].include?(el)}).sample
  end
  if position.nil?
    position = narrowed.sample
  end
  position
end 

def turn(board)
  loop do 
      puts "#{current_player(board)}'s turn. Please enter 1-9:"
      position = gets.strip.to_i - 1
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
  WIN_COMBINATIONS.detect do |line|
    line.all? { |pos| board[pos] == "X" } || line.all? { |pos| board[pos] == "O" }
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
      current_player(board) == "X" ? turn(board) : ai_turn(board, mode)
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