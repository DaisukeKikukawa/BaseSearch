class Admin::TournamentsController < Admin::BaseController
  before_action :set_tournament, only: %i[show edit update destroy]

  # GET /admin/tournaments or /admin/tournaments.json
  def index
    @q = Tournament.ransack(params[:q])
    @pagy, @tournaments = pagy(@q.result.includes(:article).order(updated_at: :desc), items: 50)
  end

  # GET /admin/tournaments/1 or /admin/tournaments/1.json
  def show
  end

  # GET /admin/tournaments/new
  def new
    @tournament_article_form = Forms::Admin::TournamentArticleForm.new
    @is_new_record = true
  end

  # GET /admin/tournaments/1/edit
  def edit
    @tournament_article_form = Forms::Admin::TournamentArticleForm.new(tournament: @tournament)
    @is_new_record = false
  end

  # POST /admin/tournaments or /admin/tournaments.json
  def create

    @tournament_article_form = Forms::Admin::TournamentArticleForm.new(params: tournament_article_form_params)
    @tournament = @tournament_article_form.save

    respond_to do |format|
      if @tournament.present?
        format.html { redirect_to admin_tournaments_url, notice: 'Tournament was successfully created.' }
        format.json { render :show, status: :created, location: @tournament }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tournaments/1 or /admin/tournaments/1.json
  def update
    @tournament_article_form = Forms::Admin::TournamentArticleForm.new(tournament: @tournament ,
params: tournament_article_form_params)
    saved_tournament = @tournament_article_form.update

    respond_to do |format|
      if saved_tournament.present?
        @tournament = saved_tournament
        format.html { redirect_to admin_tournament_url(@tournament), notice: 'Tournament was successfully updated.' }
        format.json { render :show, status: :ok, location: @tournament }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tournament.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tournaments/1 or /admin/tournaments/1.json
  def destroy
    @tournament.destroy!

    respond_to do |format|
      format.html { redirect_to admin_tournaments_url, notice: 'Tournament was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def  tournament_article_form_params
    params.require(:forms_admin_tournament_article_form).permit(:name, :title, :content)
  end
end
