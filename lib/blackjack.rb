require_relative "deck"
require_relative "hand"
require 'pry'


class Blackjack
  def initialize
    @deck = Deck.new
    @player = Hand.new(@deck.deal(2))
    @dealer = Hand.new(@deck.deal(2))
  end

  def start_game
    puts "Hello player, what is your name?"
    player_name = gets.chomp


    puts "Hello #{player_name}, are you ready for a game of Blackjack?(y/n)"
    start_game = gets.chomp

    if start_game == "y".downcase
      puts "#{player_name} and dealer have been dealt their cards"
    else
      puts "Okay, goodbye."
    end
    puts "You have been dealt: #{@player.display_hand}"
    puts "Your current score is #{@player.score}"
  end

  def winning_deal?
    binding.pry
    if @player.blackjack? && !@dealer.blackjack?
      puts "Blackjack! You win #{player_name}"
    elsif @player.blackjack? && @dealer.blackjack?
      puts "It's a push. Play again."
    elsif @dealer.blackjack? && !@player.blackjack?
      puts "Dealer has blackjack, all your chips are belong to us :-("
    end
  end

  def game
    player_hit = "h"
    while player_hit == "h"
      puts "Would like to hit or stand?(h/s)"
      player_hit = gets.chomp

      if player_hit == "h"
        puts "You have selected 'hit'"
        @player.hit(@deck.draw!)

        puts "You were dealt: #{@player.display_hit}"

        puts "You're now holding #{@player.display_hand}"
          if @player.bust?
            puts "You busted with a score of #{@player.score}, all your chips are belong to us :-("
            break
          elsif @player.score == 21
            puts "21, dealer will now show cards"
            break
          else
            puts "Your new score is #{@player.score}"
          end
      elsif player_hit == "s"
        puts "You have selected 'stand', dealer will now show cards"
      else
        puts "You have made an invalid selection, goodbye"
      end
    end
    puts "Dealer has #{@dealer.display_hand}"
    puts "Dealer's current score is #{@dealer.score}"
  end

  def end_game
    max_hit = rand(16..18)
    while @dealer.score < max_hit
      puts "Dealer will hit"
      @dealer.hit(@deck.draw!)
      puts "Dealer has been dealt: #{@dealer.display_hit}"
      puts "Dealer has #{@dealer.display_hand}"
      puts "Dealer has a score of #{@dealer.score}"
    end
    if @player.push? && @dealer.push?
      puts "The dealer and you have 21, it's a push! Play again."
    elsif @dealer.score >= max_hit && @dealer.score < 21
      puts "Dealer will stand with a score of #{@dealer.score}"
    end
  end

  def check_score
    if @dealer.score > @player.score && !@dealer.bust?
      puts "You lost, all your chips are belong to us :-("
    elsif @player.score > @dealer.score && !@player.bust?
      puts "Congratulations, you win!"
    elsif @dealer.bust? && @player.bust?
      puts "Everyone has busted. Play again."
    elsif @dealer.score == @player.score
      puts "It's a tie. Play again."
    end
  end

  def game_runner
    start_game
    winning_deal?
    game
    end_game
    check_score
  end
end
new_game = Blackjack.new
new_game.game_runner
