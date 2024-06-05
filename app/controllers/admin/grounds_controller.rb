class Admin::GroundsController < Admin::BaseController
  before_action :set_ground, only: %i[show edit update destroy]

  # GET /admin/grounds or /admin/grounds.json
  def index
    @q = Ground.ransack(params[:q])
    @pagy, @grounds = pagy(@q.result.order(updated_at: :desc), items: 50)
  end

  # GET /admin/grounds/1 or /admin/grounds/1.json
  def show
  end

  # GET /admin/grounds/new
  def new
    @ground = Ground.new
  end

  # GET /admin/grounds/1/edit
  def edit
  end

  # POST /admin/grounds or /admin/grounds.json
  def create
    @ground = Ground.new(ground_params)

    respond_to do |format|
      if @ground.save
        format.html { redirect_to admin_ground_url(@ground), notice: '作成しました' }
        format.json { render :show, status: :created, location: @ground }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ground.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/grounds/1 or /admin/grounds/1.json
  def update
    respond_to do |format|
      if @ground.update(ground_params)
        format.html { redirect_to admin_ground_url(@ground), notice: '更新しました' }
        format.json { render :show, status: :ok, location: @ground }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ground.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/grounds/1 or /admin/grounds/1.json
  def destroy
    @ground.destroy!

    respond_to do |format|
      format.html { redirect_to admin_grounds_url, notice: '削除しました', status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ground
    @ground = Ground.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ground_params
    params.fetch(:ground, {})
  end

  def ground_params
    params.require(:ground).permit(:name, :link_url, :administrative_organization, :tel, :address, :image,
                                    :google_map_url, :access, :sport, :is_public,)
  end
end
