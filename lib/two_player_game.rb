# class TwoPlayerGame
#   instance variable: whose turn it is
#   instance variable: game(ConnectFour object)

#   init should allow you to pass in game class name or game state
#   .play
#   use main.rb's keep_playing and ask_for_valid_input private methods
# frozen_string_literal: true

require './connect_four'

# class handles switching between players
class TwoPlayerGame
  PLAYER_1 = 0
  PLAYER_2 = 1

  def initialize(game = ConnectFour.new, player_1 = PLAYER_1, player_2 = PLAYER_2, current_player = PLAYER_1)
    @game = game
    @player_one = player_1
    @player_two = player_2
    @current_player = current_player
  end

  def play
    @game.welcome_message
    players
    until @game.done?
      @game.start_of_turn_message
      puts "It's #{@current_player}'s turn.'"
      input = ask_for_valid_input
      @game.play_a_turn(@current_player, input)
      switch_players
    end
    @game.final_message
  end

  private

  def players
    @player_one = @game.player_one
    @player_two = @game.player_two
    @current_player = @player_one
  end

  def ask_for_valid_input
    input = ''
    until @game.valid_input?(input)
      puts "#{@game.message_to_ask_for_input}"
      input = gets.chomp
      # return STOP_GAME_TO_SAVE if input.downcase == 'save'

      @game.invalid_input_message(input) unless @game.valid_input?(input)
    end
    input
  end

  def switch_players
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end
end

game = TwoPlayerGame.new
game.play

# puts [1..7].include?(5)
