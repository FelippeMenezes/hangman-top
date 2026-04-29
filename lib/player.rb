class Player
  attr_accessor :name, :round_guess

  def initialize(name = nil, round_guess = nil)
    @name = name
    @round_guess = round_guess
  end
end
