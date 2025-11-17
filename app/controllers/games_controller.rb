require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @grid = params[:letters].split(' ')

    is_in_grid = word_in_grid?(@word, @grid)
    is_english = english_word?(@word)

    @result = {}
    if !is_in_grid
      @result[:message] = "Sorry, #{@word} can't be built out of #{@grid.join(', ')}."
      @result[:score] = 0
    elsif !is_english
      @result[:message] = "Sorry, #{@word} doesn't seem to be a valid English word."
      result[:score] = 0
    else
      @result[:message] = "Congrats! #{@word} is a valid English word!"
      @result[:score] = @word.length
      session[:total_score] ||= 0
      session[:total_score] += word.length
    end

    total_score = session[:total_score]
  end

  private

  def word_in_grid?(word, grid)
    word.chars.all? do |letter|
      word.count(letter) <= grid.count(letter)
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json_string = URI.open(url).read
    data = JSON.parse(json_string)

    return data['found']
  end
end
