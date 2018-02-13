class Game

  def initialize
    @letters = ["w", "o", "r", "d"]
    @guess_left = 5
    @word = ["-","-","-","-"]
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

  def display_letters letter
    # Do letter match
    match = false
    @letters.each do |l|
      if letter == l
        # If there is a match, we update the @word
        match = true
        i = @letters.index(l)
        @word[i] = l
      end
    end
    # If there is no match
    @guess_left -= 1

    # Create the output string
    dash_string = ""
    @word.each do |entry|
       dash_string += entry
     end

    return dash_string
  end

end

new_game = Game.new
puts new_game.display_asc_art
puts new_game.display_letters("o")
puts new_game.display_letters("d")
