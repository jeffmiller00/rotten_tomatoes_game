require 'open-uri'

class Game < ActiveRecord::Base
  has_many :rounds
  has_many :players

  after_create :setup_game

  def setup_game
    nick_cage_movies = Array.new
    nick_cage_movies << 'Con Air'
    nick_cage_movies << 'Kick-Ass'
    nick_cage_movies << 'Knowing'
    nick_cage_movies << 'National Treasure: Book of Secrets'
    nick_cage_movies << 'Ghost Rider'
    nick_cage_movies << 'The Wicker Man'
    nick_cage_movies << 'World Trade Center'
    nick_cage_movies << 'National Treasure'
    nick_cage_movies << 'Windtalkers'
    nick_cage_movies << 'Gone in Sixty Seconds'
    nick_cage_movies << '8MM'
    nick_cage_movies << 'Snake Eyes'
    nick_cage_movies << 'The Rock'
    nick_cage_movies << 'Leaving Las Vegas'
    nick_cage_movies << 'Fast Times at Ridgemont High'

    score = -1
    while score < 0 do
        movie = nick_cage_movies.sample
        rt_url = URI::encode("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=rjn9mtwg9unwzvm35bwneev3&page_limit=1&page=1&q=#{movie}")
        movie_data = JSON.parse(HTTPI.get(rt_url).body)
        movie_data = movie_data['movies'].first
        score = movie_data['ratings']['critics_score']
    end

    r = Round.new
    r.movie = movie
    r.score = score
    r.game = self
    r.save!
  end
end
