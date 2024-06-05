class Admin::GamesController < Admin::BaseController
  before_action :set_game, only: %i[show edit update destroy]
  before_action :set_mixed_teams
  before_action :set_home_teamable, only: %i[create update]
  before_action :set_away_teamable, only: %i[create update]

  # GET /admin/games or /admin/games.json
  def index
    @teams = Team.all
    @grounds = Ground.all
    @tournament_records = TournamentRecord.all
    @teamable_types = Game.teamable_types
    @home_teamable_type = params.dig(:q, :home_teamable_type_eq)
    @away_teamable_type = params.dig(:q, :away_teamable_type_eq)
    @q = Game.ransack(params[:q])
    @pagy, @games = pagy(@q.result
                            .includes(:ground, :tournament_record, :home_teamable, :away_teamable,
                                      :game_articles, game_articles: :article)
                            .order(updated_at: :desc), items: 50)
  end

  # GET /admin/games/1 or /admin/games/1.json
  def show
  end

  # GET /admin/games/new
  def new
    @game = Game.new
    @teams = Team.all
    @grounds = Ground.all
    @tournament_records = TournamentRecord.all
  end

  # GET /admin/games/1/edit
  def edit
    @teams = Team.all
    @grounds = Ground.all
    @tournament_records = TournamentRecord.all
  end

  # POST /admin/games or /admin/games.json
  def create
    @game = Game.new(game_params)
    @teams = Team.all
    @grounds = Ground.all
    @tournament_records = TournamentRecord.all

    respond_to do |format|
      if @game.save
        format.html { redirect_to admin_game_url(@game), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/games/1 or /admin/games/1.json
  def update
    @teams = Team.all
    @grounds = Ground.all
    @tournament_records = TournamentRecord.all

    if params[:game][:away_team_name].present? && @game.away_team_id.present?
      params[:game][:away_team_id] = nil
    end

    if params[:game][:away_team_id].present? && @game.away_team_name.present?
      params[:game][:away_team_name] = nil
    end

    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to admin_game_url(@game), notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/games/1 or /admin/games/1.json
  def destroy
    @game.destroy!

    respond_to do |format|
      format.html { redirect_to admin_games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_home_teamable
    if params[:game][:home_teamable].include?("UnionTeam")
      params[:game][:home_teamable_type] = "UnionTeam"
      params[:game][:home_teamable_id] = params[:game][:home_teamable].gsub("UnionTeam", "").to_i
    else
      params[:game][:home_teamable_type] = "Team"
      params[:game][:home_teamable_id] = params[:game][:home_teamable].gsub("Team", "").to_i
    end
  end

  def set_away_teamable
    if params[:game][:away_teamable].present?
      if params[:game][:away_teamable].include?("UnionTeam")
        params[:game][:away_teamable_type] = "UnionTeam"
        params[:game][:away_teamable_id] = params[:game][:away_teamable].gsub("UnionTeam", "").to_i
      else
        params[:game][:away_teamable_type] = "Team"
        params[:game][:away_teamable_id] = params[:game][:away_teamable].gsub("Team", "").to_i
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:start_time, :ground_id, :tournament_record_id,
                                  :home_teamable_id, :home_teamable_type, :away_teamable_id, :away_teamable_type, :tag_type,
                                  :home_team_score, :away_team_score, :away_team_name
                                )
  end

  def set_mixed_teams
    @teams_and_union_teams = Team.all + UnionTeam.all
  end
end
