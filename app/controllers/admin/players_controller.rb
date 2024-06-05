class Admin::PlayersController < Admin::BaseController
  before_action :set_player, only: %i[show edit update destroy]
  before_action :convert_sub_positions_to_enum, only: [:create, :update]

  def index
    @teams = Team.all

    @q = Player.ransack(params[:q])
    @pagy, @players = pagy(@q.result.order(updated_at: :desc), items: 50)
  end

  def show
  end

  def new
    @player = Player.new
    @teams = Team.all
  end

  def edit
    @teams = Team.all
  end

  def create
    @player = Player.new(player_params)
    @teams = Team.all

    respond_to do |format|
      if @player.save
        format.html { redirect_to admin_player_url(@player),
                      notice: 'player was successfully created.'
                    }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @teams = Team.all

    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to admin_player_url(@player),
                      notice: 'player was successfully updated.'
                    }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @player.destroy!

    respond_to do |format|
      format.html { redirect_to admin_players_url, notice: 'player was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_player
    @player = Player.find(params[:id])
  end

  def player_params
    params.require(:player)
          .permit(:name, :kana, :position, :player_image, :uniform_image, :handedness,
                  :handedness_bat, :alma_mater, :catchphrase, :team_id, :birth_date,
                  :birth_date_visibility, :sub_positions,
                  )
  end

  def convert_sub_positions_to_enum
    return nil if params[:player][:sub_positions] == [""]

    params[:player][:sub_positions] = params[:player][:sub_positions].map do |sub_position|
      Player.positions[sub_position]
    end.to_s
  end
end
