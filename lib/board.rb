class Board
  attr_accessor :attempts, :correct_letters, :wrong_letters

  def initialize(attempts = 0, correct_letters = [], wrong_letters = [])
    @attempts = attempts
    @correct_letters = correct_letters
    @wrong_letters = wrong_letters
  end

  def show_board(secret_word)
    system('clear')
    puts "\n----- Hangman - The Odin project -----\n"
    puts secret_word
    puts @attempts, @correct_lettersm, @wrong_letters
    puts "\n--------------------------------------"
    print "[x] Exit"
    print "[x] Save"
    print "[L] Load a game\n"
  end
end
