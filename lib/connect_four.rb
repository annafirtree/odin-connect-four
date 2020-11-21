# frozen_string_literal: true

require 'pry'

# class represents a game of ConnectFour, with the board represented with a hash
class ConnectFour
  WHITE_TOKEN = 'U+26AA'
  BLACK_TOKEN = 'U+26AB'
  WHITE = 'White'
  BLACK = 'Black'
  WHITE_HASH = 'W'
  BLACK_HASH = 'B'
  EMPTY = 'O'
  # FULL = 'full'

  def initialize(hash = { 1 => %w[O O O O O O],
                          2 => %w[O O O O O O],
                          3 => %w[O O O O O O],
                          4 => %w[O O O O O O],
                          5 => %w[O O O O O O],
                          6 => %w[O O O O O O],
                          7 => %w[O O O O O O] })
    @board = hash
  end

  def valid_input?(input)
    input = input.to_i
    (1..7).include?(input) && !column_full?(input)
  end

  def play_a_turn(player, column)
    vertical = last_open(column)
    slots = @board.fetch(column)
    slots[vertical] = player == WHITE ? WHITE_HASH : BLACK_HASH
  end

  def done?
    winner != 'None'
  end

  def winner
    winner = search_diagonal_left
    return printable_name(winner) unless winner == EMPTY

    winner = search_diagonal_right
    return printable_name(winner) unless winner == EMPTY

    winner = search_horizontal
    return printable_name(winner) unless winner == EMPTY

    winner = search_vertical
    return printable_name(winner) unless winner == EMPTY

    return 'Tie' if board_full?

    'None'
  end

  def welcome_message
    puts 'Welcome to ConnectFour!'
  end

  def player_one
    WHITE
  end

  def player_two
    BLACK
  end

  def start_of_turn_message
    (0..5).each do |inverted_row|
      row = 5 - inverted_row
      (1..7).each do |column|
        print " #{printable(@board.fetch(column)[row])} |"
      end
      puts ' '
    end
    puts '----------------------------'
    puts ' 1 | 2 | 3 | 4 | 5 | 6 | 7 |'
  end

  def final_message
    puts "#{winner} won!"
  end

  def message_to_ask_for_input
    puts 'Which column do you pick?'
  end

  def invalid_input_message(input)
    unless (1..7).include?(input)
      puts 'Pick a number between 1 and 7.'
      return
    end
    puts 'That column is full.' if column_full?(input)
  end

  # private

  def last_open(column)
    slots = @board.fetch(column)
    slots.each_with_index { |slot, index| return index if slot == EMPTY }
  end

  def column_full?(column)
    slots = @board.fetch(column)
    slots.each { |slot| return false if slot == EMPTY }
    true
  end

  def board_full?
    (1..7).each { |column| return false unless column_full?(column) }
    true
  end

  def four_in_a_row(set)
    current = set[-1]
    counter = 1
    set.each_with_index do |slot, index|
      # binding.pry
      if slot == current && !index.zero?
        counter += 1
        return current if counter == 4
      else
        counter = 1
        current = slot
      end
    end
    EMPTY
  end

  def search_vertical
    @board.each_value do |slots|
      winner = four_in_a_row(slots)
      return winner unless winner == EMPTY
    end
    EMPTY
  end

  def search_horizontal
    (0..5).each do |row|
      set = []
      @board.each_value do |slots|
        set << slots[row]
      end
      winner = four_in_a_row(set)
      return winner unless winner == EMPTY
    end
    EMPTY
  end

  def search_diagonal_right
    (1..4).each do |start|
      set = []
      vertical_counter = start
      horizontal_counter = 0
      until vertical_counter > 7
        set << @board.fetch(vertical_counter)[horizontal_counter]
        horizontal_counter += 1
        vertical_counter += 1
      end
      winner = four_in_a_row(set)
      return winner unless winner == EMPTY
    end
    EMPTY
  end

  def search_diagonal_left
    (4..7).each do |start|
      set = []
      vertical_counter = start
      horizontal_counter = 0
      until vertical_counter < 1
        set << @board.fetch(vertical_counter)[horizontal_counter]
        vertical_counter -= 1
        horizontal_counter += 1
      end
      winner = four_in_a_row(set)
      return winner unless winner == EMPTY
    end
    EMPTY
  end

  def printable(input)
    case input
    when 'O' then 'O'
    when 'W' then WHITE_TOKEN
    when 'B' then BLACK_TOKEN
    end
  end

  def printable_name(player)
    player == 'B' ? BLACK : WHITE
  end
end
