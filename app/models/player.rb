class Player < ActiveRecord::Base
  belongs_to :game

  has_one :guess

  after_create :setup_player

  def setup_player
    g = Guess.new
    g.player = self
    g.save!
  end
end
