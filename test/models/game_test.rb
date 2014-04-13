require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "2 players (each with guesses) and 1 round get created when a game is created" do
    game = Game.create!

    assert game.rounds.size == 1
    assert game.players.size == 2

    game.players.each do |p|
      assert p.guess
    end
  end
end
