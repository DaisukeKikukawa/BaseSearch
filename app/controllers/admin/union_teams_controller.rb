class Admin::UnionTeamsController < Admin::BaseController
  before_action :set_union_team, only: [:edit, :update, :destroy, :show]

  def index
    @q = UnionTeam.ransack(params[:q])
    @pagy, @union_teams = pagy(@q.result.order(updated_at: :desc), items: 50)
  end

  def show
  end

  def new
    @union_team = UnionTeam.new
    @teams = Team.all
    @union_team.team_unions_teams.build
  end

  def edit
    @teams = Team.all
  end

  def create
    @union_team = UnionTeam.new(union_team_params)
    @union_team.team_ids_param = params[:team_ids]

    respond_to do |format|
      if @union_team.save
        params[:team_ids].reject(&:blank?).each do |team_id|
          TeamUnionsTeam.create(union_team: @union_team, team_id:)
        end
        format.html { redirect_to admin_union_team_url(@union_team), notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @union_team }
      else
        @teams = Team.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @union_team.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @union_team.team_ids_param = params[:team_ids]

    respond_to do |format|
      if @union_team.update(union_team_params)
        @union_team.team_unions_teams.destroy_all
        params[:team_ids].each do |team_id|
          @union_team.team_unions_teams.create(team_id:) unless team_id.blank?
        end
        format.html { redirect_to admin_union_team_url(@union_team), notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @union_team }
      else
        @union_teams = UnionTeam.all
        @teams = Team.all
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @union_team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @union_team.destroy
    @union_team.team_unions_teams.destroy_all

    respond_to do |format|
      format.html { redirect_to admin_union_teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_union_team
    @union_team = UnionTeam.find(params[:id])
  end

  def union_team_params
    params.require(:union_team).permit(:name)
  end

end
