class Cards

  attr_accessor :suit, :face, :value

  def initialize(face, suit)
    self.face = face
    self.suit = suit
    if face == "A"
      self.value = 11
    elsif face == "K" || face == "Q" || face == "J"
      self.value = 10
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
