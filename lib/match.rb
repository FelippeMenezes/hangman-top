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
    @board.show_board(@secret_word, self)
  end

  def ask_player_round_guess
    print "#{@player.name}, what's your guess? => "
    @player.round_guess = gets.chomp
    @board.attempts += 1
  end

  private

  def ask_player_name
    print "What's your name? => "
    @player.name = gets.chomp
  end

  def select_sample_secret_word
    @secret_word = File.readlines("google-10000-english-no-swears.txt")
                        .map { |word| word.chomp }
                        .select { |word| word.length.between?(5, 12) }
                        .sample
  end
end
