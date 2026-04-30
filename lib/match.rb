require 'yaml'

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
    print "#{@player.name}, what's your guess? => "
    @player.round_guess = gets.chomp.downcase
    @board.attempts += 1
  end

  private

  def ask_player_name
    print "What's your name? => "
    @player.name = gets.chomp.capitalize
  end

  def select_sample_secret_word
    @secret_word = File.readlines("google-10000-english-no-swears.txt")
                        .map { |word| word.chomp }
                        .select { |word| word.length.between?(5, 12) }
                        .sample
  end

  def play
    loop do
      @board.show_board(@secret_word, self, @player.round_guess)
      if @player.round_guess == @secret_word || @secret_word.chars.uniq.sort == @board.correct_letters.sort
        puts "You won!"
        break
      end
      if @board.attempts >= 15
        puts "\nGame Over! The Secret Word was #{secret_word}.\n\n"
        break
      end
      break if @player.round_guess == "1"
      save_game if @player.round_guess == "2"
      if @player.round_guess == "3"
        loaded = load_game
        # Se carregou com sucesso, continua o loop do zero
        # (o loop vai chamar show_board com o estado restaurado)
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

    File.open('data_base.yaml', 'w') do |file|
      file.write(YAML.dump(game_state))
    end

    puts "Game saved Successfully"
  end

  def load_game
    unless File.exist?('data_base.yaml')
      puts "No saved game found!"
      return false
    end

    game_state =YAML.safe_load(
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
