class Admin::TeamCategoriesController < Admin::BaseController
  before_action :set_team_category, only: %i[show edit update destroy]

  def index
    @q = TeamCategory.ransack(params[:q])
    @pagy, @team_categories = pagy(@q.result.order(updated_at: :desc), items: 50)
  end

  def show
  end

  def new
    @team_category = TeamCategory.new
  end

  def edit
  end

  def create
    @team_category = TeamCategory.new(team_category_params)

    respond_to do |format|
      if @team_category.save
        format.html { redirect_to admin_team_category_url(@team_category),
                      notice: 'team_category was successfully created.'
                    }
        format.json { render :show, status: :created, location: @team_category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @team_category.update(team_category_params)
        format.html { redirect_to admin_team_category_url(@team_category),
                      notice: 'team_category was successfully updated.'
                    }
        format.json { render :show, status: :ok, location: @team_category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team_category.destroy!

    respond_to do |format|
      format.html { redirect_to admin_team_categories_url, notice: 'team_category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_team_category
    @team_category = TeamCategory.find(params[:id])
  end

  def team_category_params
    params.require(:team_category).permit(:name)
  end
end
