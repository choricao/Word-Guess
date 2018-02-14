require 'random-word'
require 'colorize'

class Game
  attr_reader :ran_word, :orig_letters, :disp_letters, :wrong_letters, :guess_left

  # Constructor
  def initialize
    @ran_word = RandomWord.nouns(not_longer_than: 10).next
    @orig_letters = @ran_word.split(//)
    @disp_letters = generate_dashes
    @wrong_letters = []
    @guess_left = @orig_letters.length
  end

  # Generate an array of dash for initialization of instance
  def generate_dashes
    dash_array = []
    @orig_letters.length.times do
      dash_array.push("-")
    end
    return dash_array
  end

  # Compare user input with the hidden word
  # Output different messages based on results
  def match letter
    match = false
    @orig_letters.each_index do |i|
      if letter == @orig_letters[i]
        match = true
        @disp_letters[i] = letter
      end
    end

    if match
      puts "Great job! You guessed right."
    else
      if @wrong_letters.include?(letter)
        puts "You already guessed this letter."
      else
        puts "Sorry. You guessed wrong."
        @guess_left -= 1
        @wrong_letters << letter
      end
    end
  end

  # Display list of wrong guesses
  def display_wrong_guesses
    print "List of wrong guesses: "
    @wrong_letters.each do |l|
      print "#{l}  "
    end
    puts "\n"
  end

  # Display ASCII art with different colors
  def display_asc_art
    art = ""
    flower = "(@)".red
    @guess_left.times do
      art += flower
    end
    stem = """
,\\,\\,|,/,/,
   _\\|/_""".green
    pot = """
  |_____|
   |   |
   |___|
   """.blue
    art += stem
    art += pot
    puts art
  end

  # Display the hidden word based on previous guesses
  def display_word
    dash_string = ""
    @disp_letters.each do |l|
       dash_string += l
    end
    puts dash_string
  end

end

# Helper method to validate user's input
def valid_input
  input = gets.chomp
  until /[a-zA-Z]/.match(input) && input.size == 1
    print "Please enter a valid letter: "
    input = gets.chomp
  end
  return input
end

# Welcome message and initial status of the game
puts "Welcome to the Word Guess game."
new_game = Game.new
new_game.display_asc_art
new_game.display_word

# Game loops
win = true
until new_game.orig_letters == new_game.disp_letters
  if new_game.guess_left > 0
    print "Please enter your guess (one letter a time ONLY): "
    guess_letter = valid_input.downcase
    new_game.match(guess_letter)
    new_game.display_wrong_guesses
    new_game.display_asc_art
    new_game.display_word
  else
    puts "Sorry... you lost... The word is #{new_game.ran_word}."
    exit
  end
end
puts "Congratulations, you won!"
