# frozen_string_literal: true

require 'yaml'

# Match class
class Match
  attr_accessor :player, :board, :games_saved, :secret_word

  def initialize(player, board, games_saved = nil, secret_word = nil)
    @player = player
    @board = board
    @games_saved = games_saved
    @secret_word = secret_word
  end

  def self.create
    @match = Match.new(Player.new, Board.new)
    @match.start
  end

  def start
    ask_player_name
    select_sample_secret_word
    play
  end

  def ask_player_round_guess
    print "#{@player.name}, what's your guess? => ".colorize(:blue)
    @player.round_guess = gets.chomp.downcase
    @board.attempts += 1
  end

  private

  def ask_player_name
    system('clear')
    print "What's your name? => ".colorize(:blue)
    @player.name = gets.chomp.capitalize
  end

  def select_sample_secret_word
    @secret_word = File.readlines('google-10000-english-no-swears.txt')
                       .map(&:chomp)
                       .select { |word| word.length.between?(5, 12) }
                       .sample
  end

  def play
    loop do
      @board.show_board(@secret_word, self, @player.round_guess)
      if @player.round_guess == @secret_word || @secret_word.chars.uniq.sort == @board.correct_letters.sort
        puts '---------------You won!---------------'.colorize(:green)
        break
      end
      if @board.attempts >= 15
        print 'Game Over!'.colorize(:red)
        puts " The Secret Word was #{secret_word.colorize(:green)}."
        break
      end
      break if @player.round_guess == '1'

      save_game if @player.round_guess == '2'
      if @player.round_guess == '3'
        loaded = load_game
        next if loaded
      end
      ask_player_round_guess
    end
  end

  def save_game
    game_state = {
      secret_word: @secret_word,
      player_name: @player.name,
      attempts: @board.attempts,
      correct_letters: @board.correct_letters,
      wrong_letters: @board.wrong_letters
    }
    File.open('data_base.yaml', 'w') { |file| file.write(YAML.dump(game_state)) }
    puts 'Game saved Successfully'.colorize(:green)
  end

  def load_game
    unless File.exist?('data_base.yaml')
      puts 'No saved game found!'.colorize(:red)
      return false
    end
    game_state = YAML.safe_load(
      File.read('data_base.yaml'),
      permitted_classes: [Symbol],
      symbolize_names: true
    )
    @secret_word = game_state[:secret_word]
    @player.name = game_state[:player_name]
    @board.attempts = game_state[:attempts]
    @board.correct_letters = game_state[:correct_letters]
    @board.wrong_letters = game_state[:wrong_letters]
    @board.show_board(@secret_word, self, @player.round_guess)
  end
end
