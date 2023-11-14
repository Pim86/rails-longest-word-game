require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @guess = params[:word]
    guess_chars = @guess.chars
    @letters = params[:letters].split(" ")
    # Check is word exists in english dictinary
    url = "https://wagon-dictionary.herokuapp.com/#{@guess}"
    # Check if letters match @letters
    response = URI.open(url)
    response_json = JSON.parse(response.read)

    @answer =
      if response_json['found']
        if (guess_chars - @letters).empty?
          @score = calc_score(@guess, @letters)
          "boa" # palavra ok
        else
          "quase" # palavra nok, letras fora do @letters
        end
      else
        "Word doesn't exist."
      end
  end

  private

  def calc_score(guess, letters)
    # se guess for igual letters = 10 pontos
    # pontos = 10 - (letters.size - guess.length)
    10 - (letters.size - guess.length)
  end
end
