class Admin::TeamsController < Admin::BaseController
  before_action :set_team, only: %i[show edit update destroy]

  # GET /admin/teams or /admin/teams.json
  def index
    @team_categories = TeamCategory.all

    @q = Team.ransack(params[:q])
    @pagy, @teams = pagy(@q.result.order(updated_at: :desc), items: 50)
  end

  # GET /admin/teams/1 or /admin/teams/1.json
  def show
  end

  # GET /admin/teams/new
  def new
    @team = Team.new
    @team_categories = TeamCategory.all
  end

  # GET /admin/teams/1/edit
  def edit
    @team_categories = TeamCategory.all
  end

  # POST /admin/teams or /admin/teams.json
  def create
    @team = Team.new(team_params)
    @team_categories = TeamCategory.all

    respond_to do |format|
      if @team.save
        format.html { redirect_to admin_team_url(@team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/teams/1 or /admin/teams/1.json
  def update
    @team_categories = TeamCategory.all

    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to admin_team_url(@team), notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/teams/1 or /admin/teams/1.json
  def destroy
    @team.destroy!

    respond_to do |format|
      format.html { redirect_to admin_teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def team_params
    params.require(:team).permit(:name, :team_category_id, :recruitment_position, :team_introduction,
                                  :school_name, :representative_name, :coach_name, :activity_base, :activity_day,
                                  :historical_records, :team_icon, :team_logo, :team_uniform,
                                  :facebook_url, :x_url, :instagram_url, :email, :team_image
                                )
  end
end
