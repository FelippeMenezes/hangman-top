class Board
  attr_accessor :attempts, :correct_letters, :wrong_letters

  def initialize(attempts = 0, correct_letters = [], wrong_letters = [])
    @attempts = attempts
    @correct_letters = correct_letters
    @wrong_letters = wrong_letters
  end

  def show_board(secret_word, match, round_guess)
    system('clear')
    puts "\n----- Hangman - The Odin project -----\n"
    show_secret_letters(secret_word, round_guess)
    puts "\nAttempts #{@attempts}"
    puts "Correct Letters: #{@correct_letters.join(" - ")}"
    puts "Wrong Letters: #{@wrong_letters.join(" - ")}"
    puts "\n--------------------------------------"
    print "[1] Exit   "
    print "[2] Save   "
    print "[3] Load a game\n"
  end

  private

  def show_secret_letters(secret_word, player_round_guess)
    if secret_word.chars.include?(player_round_guess) && player_round_guess != nil
      check_repeated_guess(player_round_guess)
      puts ""
      secret_word.chars.each do |letter|
        if @correct_letters.include?(letter)
          print " #{letter} "
        else
          print "#{" _ "}"
        end
      end
    puts "\n\nThe Secret Word has #{secret_word.length} letters."
    elsif player_round_guess != nil
      unless @wrong_letters.include?(player_round_guess)
        @wrong_letters << player_round_guess
      else
        @attempts -= 1
        puts "You've tried this letter '#{player_round_guess}' before!"
      end
      puts ""
      secret_word.chars.each do |letter|
        if @correct_letters.include?(letter)
          print " #{letter} "
        else
          print "#{" _ "}"
        end
      end
    puts "\n\nThe Secret Word has #{secret_word.length} letters."
    elsif attempts == 0
      puts "\n#{secret_word.gsub(/[a-z]/, " _ ")}"
      puts "\nThe Secret Word has #{secret_word.length} letters."
    end
  end

  def check_repeated_guess(player_round_guess)
    unless @correct_letters.include?(player_round_guess)
      @correct_letters << player_round_guess
    else
      @attempts -= 1
      puts "You've tried this letter '#{player_round_guess}' before!"
    end
  end
end
