class Board
  attr_accessor :attempts, :correct_letters, :wrong_letters

  def initialize(attempts = 0, correct_letters = [], wrong_letters = [])
    @attempts = attempts
    @correct_letters = correct_letters
    @wrong_letters = wrong_letters
  end

  def show_board(secret_word, match, round_guess)
    system('clear')
    puts "\n----- Hangman - The Odin project -----\n".colorize(:blue)
    show_secret_letters(secret_word, round_guess)
    puts "\nAttempts: #{@attempts.to_s.colorize(:yellow)}"
    puts "Correct Letters: #{@correct_letters.join(" - ").colorize(:green)}"
    puts "Wrong Letters: #{@wrong_letters.join(" - ").colorize(:red)}"
    puts "\n--------------------------------------"
    print "[1] Exit   ".colorize(:red)
    print "[2] Save   ".colorize(:green)
    print "[3] Load a game\n".colorize(:yellow)
  end

  private

  def show_secret_letters(secret_word, player_round_guess)
    if player_round_guess.nil?
      hide_secret_word(secret_word)
    elsif %w[1 2 3].include?(player_round_guess)
      @attempts -= 1
      show_correct_letter(secret_word)
    elsif !player_round_guess.match?(/^[a-z]+$/)
      @attempts -= 1
      puts "Only letters are allowed!".colorize(:red)
      show_correct_letter(secret_word)
    elsif secret_word.chars.include?(player_round_guess)
      check_correct_repeated_guess(player_round_guess)
      show_correct_letter(secret_word)
    else
      check_wrong_repeated_guess(player_round_guess)
      show_correct_letter(secret_word)
    end
  end

  def check_correct_repeated_guess(player_round_guess)
    if @correct_letters.include?(player_round_guess)
      @attempts -= 1
      puts "You've tried this letter '#{player_round_guess.colorize(:yellow)}' before!"
    else
      @correct_letters << player_round_guess
    end
  end

  def check_wrong_repeated_guess(player_round_guess)
    if @wrong_letters.include?(player_round_guess)
      @attempts -= 1
      puts "You've tried this letter '#{player_round_guess.colorize(:yellow)}' before!"
    else
      @wrong_letters << player_round_guess
    end
  end

  def show_correct_letter(secret_word)
    puts ""
    secret_word.chars.each do |letter|
      if @correct_letters.include?(letter)
        print " #{letter.colorize(:green)} "
      else
        print "#{" _ ".colorize(:blue)}"
      end
    end
    puts "\n\nThe Secret Word has #{secret_word.length} letters.".colorize(:blue)
  end

  def hide_secret_word(secret_word)
    puts "\n#{secret_word.gsub(/[a-z]/, " _ ")}".colorize(:blue)
    puts "\nThe Secret Word has #{secret_word.length} letters.".colorize(:blue)
  end
end
