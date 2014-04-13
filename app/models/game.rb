class Game < ActiveRecord::Base
  has_many :rounds
  has_many :players

  after_create :setup_game

  def setup_game
    r = Round.new
    r.movie = 'Noah'
    r.score = 77
    r.game = self
    r.save!

    2.times do |n|
      p = Player.new
      p.name = "Player #{n}"
      p.game = self
      p.save!
    end
  end
end
