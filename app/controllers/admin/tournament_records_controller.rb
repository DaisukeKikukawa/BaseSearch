class Admin::TournamentRecordsController < Admin::BaseController
  before_action :set_admin_tournament_record, only: %i[ show edit update destroy ]

  # GET /admin/tournament_records or /admin/tournament_records.json
  def index
    @q = TournamentRecord.ransack(params[:q])
    @pagy, @tournament_records = pagy(@q.result.order(updated_at: :desc), items: 50)
  end

  # GET /admin/tournament_records/1 or /admin/tournament_records/1.json
  def show
  end

  # GET /admin/tournament_records/new
  def new
    @tournament_record = TournamentRecord.new
    @tournaments = Tournament.all
  end

  # GET /admin/tournament_records/1/edit
  def edit
    @tournaments = Tournament.all
  end

  # POST /admin/tournament_records or /admin/tournament_records.json
  def create
    @tournaments = Tournament.all
    @tournament_record = TournamentRecord.new(tournament_record_params)

    respond_to do |format|
      if @tournament_record.save
        format.html {
          redirect_to admin_tournament_record_url(@tournament_record),
          notice: "Tournament record was successfully created."
        }
        format.json { render :show, status: :created, location: @tournament_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tournament_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tournament_records/1 or /admin/tournament_records/1.json
  def update
    respond_to do |format|
      if @tournament_record.update(tournament_record_params)
        format.html {
          redirect_to admin_tournament_record_url(@tournament_record),
          notice: "Tournament record was successfully updated."
        }
        format.json { render :show, status: :ok, location: @tournament_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tournament_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tournament_records/1 or /admin/tournament_records/1.json
  def destroy
    @tournament_record.destroy!

    respond_to do |format|
      format.html { redirect_to admin_tournament_records_url, notice: "Tournament record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_tournament_record
    @tournament_record = TournamentRecord.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tournament_record_params
    params.require(:tournament_record).permit(:tournament_id, :name, :started_at, :ended_at)
  end
end
