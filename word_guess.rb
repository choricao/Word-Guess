# require 'random-word'

class Game
  attr_reader :hid_word, :guess_left, :orig_word

  def initialize
    @orig_word = ["z", "h", "e", "n", "g"]
    @guess_left = @orig_word.length
    @hid_word = ["-","-","-","-","-"]
  end

  def display_asc_art
    art = ""
    flower = "(@)"
    @guess_left.times do
      art += flower
    end
    pot = """
,\\,\\,|,/,/,
   _\\|/_
  |_____|
   |   |
   |___|
    """
    art += pot
    return art
  end

  def match letter
    # Do letter match
    match = false
    @orig_word.each_index do |i|
      if letter == @orig_word[i]
        # If there is a match, we update the @hid_word
        match = true
        @hid_word[i] = letter
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
    @hid_word.each do |entry|
       dash_string += entry
    end
    return dash_string
  end

end

puts "Welcome to the Word Guess game." ## Add instruction ##
new_game = Game.new
puts new_game.display_asc_art
puts new_game.display_word

win = true
until new_game.orig_word == new_game.hid_word
  if new_game.guess_left > 0
    print "Please enter your guess (one letter a time ONLY): "
    guess_letter = gets.chomp## Add user input check ##
    new_game.match(guess_letter)
    puts new_game.display_asc_art
    puts new_game.display_word
  else
    puts "Sorry... you lost...."
    exit
  end
end

puts "Congratulations, you won!"

# rand_word = RandomWord.nouns(not_longer_than: 10).next
# puts rand_word
