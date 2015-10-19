require_relative "cards"

class Deck

  attr_accessor :cards

  def initialize
    poss_cards = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    poss_suits = %w(♣ ♠ ♥ ♦)
    self.cards = []
    poss_suits.each do |suit|
      poss_cards.each do |face|
        self.cards << Cards.new(face,suit)
      end
    end
  end

  def shuffle
    self.cards = cards.shuffle
  end

  def draw
    cards.shift
  end

end
