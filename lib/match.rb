class Match
  attr_accessor :player, :board, :secret_word, :games_saved

  def initialize(player, board, games_saved = nil, secret_word = nil)
    @player = player
    @board = board
    @games_saved = games_saved
    @secret_word = secret_word
  end
end
