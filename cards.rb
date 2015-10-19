class Cards

  attr_accessor :suit, :face, :value

  def initialize(face, suit)
    self.face = face
    self.suit = suit
    if face == "Ace"
      self.value = 14
    elsif face == "King"
      self.value = 13
    elsif face == "Queen"
      self.value = 12
    elsif face == "Jack"
      self.value = 11
    else
      self.value = face.to_i
    end
  end

  def >(this_card)
    self.value > this_card.value
  end

  def <(this_card)
    self.value < this_card.value
  end

end
