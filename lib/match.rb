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
      ask_player_round_guess
    end
  end
end
