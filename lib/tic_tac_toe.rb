WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Top row
  [0,3,6], # Left column
  [1,4,7], # Middle column
  [2,5,8], # Right column
  [0,4,8], # Left-right X
  [6,4,2]  # Right-left X
]

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  until valid_move?(board, input)
 puts "Please enter 1-9:"
  input = gets.chomp
end
    move(board, input, current_player(board))
    display_board(board)
end

def display_board(board = [" "," "," "," "," "," "," "," "," "])
  line = "-----------"
  row1 = " #{board[0]} | #{board[1]} | #{board[2]} "
  row2 = " #{board[3]} | #{board[4]} | #{board[5]} "
  row3 = " #{board[6]} | #{board[7]} | #{board[8]} "
puts row1
puts line
puts row2
puts line
puts row3
end

def valid_move?(board, position)
  num = position.to_i
  if num.between?(1,9) && (position_taken?(board, num - 1) == false)
    return true
  else
    false
  end
end

def position_taken?(board, position)
  if board[position.to_i] == " " || board[position.to_i] == "" || board[position.to_i] == nil
    false
  else
    true
  end
end

def move(board, position, token)
  board[position.to_i - 1] = token
end

def turn_count(board)
  counter = 0
  board.each do |position|
    if position == "X" || position == "O" || position == "x" || position == "o"
      counter += 1
    else
    end
  end
    counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end




def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]
    position_1 = board[win_index_1] # load the value of the board at win_index_1
    position_2 = board[win_index_2] # load the value of the board at win_index_2
    position_3 = board[win_index_3] # load the value of the board at win_index_3
    if (position_1 == "X" && position_2 == "X" && position_3 == "X") || (position_1 == "O" && position_2 == "O" && position_3 == "O")
    return win_combination # return the win_combination indexes that won.
  else
    false
  end
  end
  return false
end

def full?(board)
  return board.all? { |position| position == "X" || position == "O"}
end

def draw?(board)
  if won?(board) || !full?(board)
    false
  else
    true
  end
end

def over?(board)
  if won?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  result = won?(board)
  if !result
    return nil
  elsif board[result[0]] == "X"
    return "X"
  else
    return "O"
  end
end

def play(board)
  while !over?(board)
    turn(board)
    if won?(board)
      puts "Congratulations #{winner(board)}!"
      break
    elsif draw?(board)
      puts "Cat's Game!"
      break
    end
  end
end
