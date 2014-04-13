class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy, :play, :enter_score, :finish]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  def new
    @game = Game.new

    @players = Array.new
    5.times do |i|
      @players[i] = "Player #{i+1}"
    end
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    params[:players].each do |player_name|
      p = Player.new
      p.name = player_name
      p.game = @game
      p.save!
    end

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @game }
      else
        format.html { render action: 'new' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  def play
    @first_round = @game.rounds.first
    @players = @game.players

    all_done = true
    @players.each do |p|
      if p.guess.attempt.blank?
        all_done = false
      end
    end

    if all_done
      redirect_to action: 'finish', id: params[:id]
    end
  end

  def enter_score
    Guess.update(params[:guess_id], :attempt => params[:attempt])
    redirect_to action: 'play', id: params[:id], notice: 'Guess posted.'
  end

  def finish
    @first_round = @game.rounds.first
    @best_diff = 101
    @best_player = nil

    @game.players.each do |p|
      if (@game.rounds.first.score - p.guess.attempt).abs < @best_diff
        @best_diff = (@game.rounds.first.score - p.guess.attempt).abs
        @best_player = p
      end
    end
  end

  def welcome
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params[:game]
    end
end
