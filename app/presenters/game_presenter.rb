class GamePresenter
  attr_reader :game


  ALPHABET = ('A'..'Z')

  def initialize(input, output, game)
    @input = input
    @output = output
    @game = game
  end

  def welcome_player
    clear_screen
    print "Welcome to hangman. Guess a letter."
    print_board
  end

  def ask_for_letter
    while user_input = get_normalized_input
      return user_input if valid_letter?(user_input)
      report_invalid_input
    end
  end

  def report_correct_guess
    clear_screen
    print "You guessed correctly!"
    print_game

  end

  def report_incorrect_guess
    clear_screen
    print "Sorry, you guessed incorrectly"
    print_game

  end

  def report_game_lost
    print "Sorry, you're dead."
  end

  def report_game_won
    print "You guessed correctly! You live to see another day"
  end
  
  private

  def valid_letter?(letter)
    ALPHABET.include?(letter)
  end

  def get_normalized_input
    @input.gets.upcase.chomp
  end

  def print_game

    print "Thusfar, you've guessed:"
    print  guessed_letters_to_string
    print "You have #{game.letters_remaining.length} letters remaining" # TODO Grammar.
    print "You have #{game.lives_remaining} lives remaining"
    print_board
    print "Guess Again:" unless game.finished?
  end

  def guessed_letters_to_string
    game.guessed_letters.uniq.join(" ")
  end

  def print_board
    print game.board.join(" ")
  end

  def clear_screen
    system "clear"
  end

  def print(string)
    @output.puts(string)
  end

  def report_invalid_input
    print "Please select a single letter in the English alphabet:"
  end
end