require_relative "blackjack_cards"
require_relative "blackjack_deck"

class Blackjack

attr_accessor :player_hand, :computer_hand, :p_score, :c_score, :bjdeck, :shoe

  def initialize
    puts "Welcome to Blackjack, sir. Please press [Enter] to deal."
    STDIN.gets
    self.p_score = 0
    self.c_score = 0
    self.shoe = []
    self.bjdeck = Deck.new
    bjdeck.shuffle
    self.player_hand = []
    self.computer_hand = []
  end


  def play
    2.times {deal}
    blind_score
    if player_hand.collect{|x| x.value}.inject(:+) == 21
      bjwin
    elsif computer_hand.collect{|x| x.value}.inject(:+) == 21
      bjlose
    else
    action
    end
  end

  def deal
      hit = bjdeck.draw
      self.player_hand << hit
      hit = bjdeck.draw
      self.computer_hand << hit
    end

    def action
      if player_hand.collect{|x| x.value}.inject(:+) < 21 && player_hand.length == 6
        lengthwin
      else
        puts "Would you like to 'hit' or 'stay'?"
        answer = STDIN.gets.chomp.downcase
        until answer == "hit" || answer == "stay"
          puts "Simply let me know if you would like to 'hit' or 'stay', sir."
          answer = STDIN.gets.chomp
        end
        if answer == "hit"
          hit = bjdeck.draw
          player_hand << hit
          blind_score
          if player_hand.collect{|x| x.value}.inject(:+) > 21
            puts "It appears you have busted."
            lose
          else
            action
          end
        else
          computer_turn
        end
      end
    end

    def computer_turn
      puts "Very well, sir. Please press [Enter] for my turn"
      STDIN.gets.chomp
      until computer_hand.collect{|x| x.value}.inject(:+) > 16
        puts "I will hit, sir."
        hit = bjdeck.draw
        computer_hand << hit
        score
      end
      if computer_hand.collect{|x| x.value}.inject(:+) > 21
        puts "Oh dear. I seem to have busted, sir."
        win
      else
        score
        if player_hand.collect{|x| x.value}.inject(:+) > computer_hand.collect{|x| x.value}.inject(:+)
          win
        elsif computer_hand.collect{|x| x.value}.inject(:+) > player_hand.collect{|x| x.value}.inject(:+)
          lose
        else
          puts "We seem to have tied. The bigger hand wins."
          x = player_hand.length
          y = computer_hand.length
          puts "Your hand has #{x} cards, and mine has #{y}."
          if computer_hand.length < player_hand.length
            win
          elsif computer_hand.length > player_hand.length
            lose
          else
            puts "(Our hands are the same length)"
            win
          end
        end
      end
    end

    def blind_score
      p_score = player_hand.collect{|x| x.value}.inject(:+)
      c_score = computer_hand.collect{|x| x.value}.inject(:+)
      puts "You have #{player_hand.collect{|x| "#{x.face}#{x.suit}"}.join(" & ")}, for a total of #{p_score}"
      puts "The computer has #{computer_hand[1].face}#{computer_hand[1].suit} & [#]"
      puts " "
    end

    def score
      p_score = player_hand.collect{|x| x.value}.inject(:+)
      c_score = computer_hand.collect{|x| x.value}.inject(:+)
      puts "You have #{player_hand.collect{|x| "#{x.face}#{x.suit}"}.join(" & ")}, for a total of #{p_score}"
      puts "The computer has #{computer_hand.collect{|x| "#{x.face}#{x.suit}"}.join(" & ")}, for a total of #{c_score}"
      puts " "
    end

    def win
      puts "Congratulations, sir. You seem to have bested me."
      restart
    end

    def bjwin
      puts "You have been dealt a Black Jack, sir. Congratulations. You win."
      restart
    end

    def lengthwin
      puts "You have six cards, and are under 21. Congratulations, you win."
      restart
    end

    def bjlose
      puts "I'm sorry, sir. I seem to have been dealt a Black Jack. I win."
      restart
    end

    def lose
      puts "I'm sorry, sir. You seem to have lost."
      restart
    end

    def restart
      puts "Would you like to play again? (Yes or No)"
      answer = STDIN.gets.chomp.downcase
      until answer == "yes" || answer == "no"
        puts "That was not a response I was expecting..."
        puts "Would you like to play again? (Yes or No)"
        answer = STDIN.gets.chomp.downcase
      end
      if answer == "yes"
        puts "-------------------"
        initialize
        play
      else answer == "no"
        puts "Thank you for playing."
      end
    end


end

toast = Blackjack.new
toast.play
