require 'pry-byebug'

class Board
  attr_accessor :attempts, :correct_letters, :wrong_letters

  def initialize(attempts = 0, correct_letters = [], wrong_letters = [])
    @attempts = attempts
    @correct_letters = correct_letters
    @wrong_letters = wrong_letters
  end

  def show_board(secret_word, match, round_guess)
    puts "\n----- Hangman - The Odin project -----\n"
    show_secret_letters(secret_word, round_guess)
    puts "Attempts #{@attempts}"
    puts "Correct Letters: #{@correct_letters.join(" - ")}"
    puts "Wrong Letters: #{@wrong_letters.join(" - ")}"
    puts "\n--------------------------------------"
    print "[1] Exit   "
    print "[2] Save   "
    print "[3] Load a game\n"
    match.ask_player_round_guess
  end

  private

  def show_secret_letters(secret_word, player_round_guess)
    if secret_word.chars.include?(player_round_guess) && player_round_guess != nil
      puts "Teste"
      @correct_letters << player_round_guess
    elsif player_round_guess != nil
      @wrong_letters << player_round_guess
    end
  end
end
