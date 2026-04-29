class Match
  attr_accessor :player, :board, :secret_word, :games_saved

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
  end

  private

  def ask_player_name
    print "What's your name? => "
    @player.name = gets.chomp
  end

  def select_sample_secret_word
    file = File.open("google-10000-english-no-swears.txt")

    while line = file.gets do
      line if line.length >= 5 && line.length <= 12
      p line
    end

    file.close
  end
end
