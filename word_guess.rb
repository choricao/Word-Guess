require 'random-word'
require 'colorize'

class Game
  attr_reader :ran_word, :orig_letters, :dis_letters, :guess_left

  def initialize
    @ran_word = RandomWord.nouns(not_longer_than: 10).next
    @orig_letters = @ran_word.split(//)
    @dis_letters = generate_dashes
    @guess_left = @orig_letters.length
  end

  def generate_dashes
    dash_array = []
    @orig_letters.length.times do
      dash_array.push("-")
    end
    return dash_array
  end

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
    return art
  end

  def match letter
    # Do letter match
    match = false
    @orig_letters.each_index do |i|
      if letter == @orig_letters[i]
        # If there is a match, we update the @dis_letters
        match = true
        @dis_letters[i] = letter
      end
    end

    if match
      puts "Great job! You guessed right."
    else
      puts "Sorry. Try again."
      @guess_left -= 1
    end

  end

  def display_word
    # Create the output string
    dash_string = ""
    @dis_letters.each do |entry|
       dash_string += entry
    end
    return dash_string
  end
end


puts "Welcome to the Word Guess game."
new_game = Game.new
puts new_game.display_asc_art
puts new_game.display_word

win = true
until new_game.orig_letters == new_game.dis_letters
  if new_game.guess_left > 0
    print "Please enter your guess (one letter a time ONLY): "
    guess_letter = gets.chomp## Add user input check ##
    new_game.match(guess_letter)
    puts new_game.display_asc_art
    puts new_game.display_word
  else
    puts "Sorry... you lost... The word is #{new_game.ran_word}."
    exit
  end
end

puts "Congratulations, you won!"
