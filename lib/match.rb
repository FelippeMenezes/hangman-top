class Match
  attr_accessor :player, :board, :secret_word, :games_saved

  def initialize(player, board, games_saved = nil, secret_word = nil)
    @player = player
    @board = board
    @games_saved = games_saved
    @secret_word = secret_word
  end

  def self.start
    @player = Player.new
    @board = Board.new
    @match = Match.new(@player, @board)
    @match.ask_player_name
  end

  def ask_player_name
    print "What's your name? => "
    @player.name = gets.chomp
  end
end
