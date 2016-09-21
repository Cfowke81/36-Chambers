require_relative "card"
require_relative "deck"
require 'pry'

class Hand
  attr_accessor :cards

  def initialize(cards=[])
    @cards = cards
  end

  def hit(card)
    @cards << card
  end

  def display_hand
    display = @cards.map { |card| card.show_card }.join(", ")
    display
  end

  def display_hit
    display = @cards.map { |card| card.show_card }.join(", ")
    display.split(//).last(3).join
  end

  def score
    total_score = 0
    num_of_aces = 0
    @cards.each do |card|
      if card.face_card?
        total_score += 10
      elsif card.ace?
        total_score += 11
        num_of_aces += 1
      else
        total_score += card.rank.to_i
      end
      while total_score > 21 && num_of_aces > 0
        total_score -= 10
        num_of_aces -= 1
      end
    end
    total_score
  end

  def bust?
    score > 21
  end

  def blackjack?
    score == 21 && @cards.count == 2
  end

  def push?
    score == 21 && @cards.count > 2
  end
end
