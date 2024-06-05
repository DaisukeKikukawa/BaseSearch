class Admin::ArticlesController < Admin::BaseController
  before_action :find_game
  before_action :find_game_article, only: [:show, :edit, :destroy, :update]

  def show
    @article = @game_article.article
  end

  def new
    @game_article = @game.game_articles.new
    @article = @game_article.build_article
  end

  def create
    @game_article = @game.game_articles.build(game_article_params)
    @article = @game_article.build_article(article_params)

    respond_to do |format|
      if @game_article.save
        format.html { redirect_to admin_games_path, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @game_article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_article.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @article = @game_article.article
  end

  def update
    @article = @game_article.article

    respond_to do |format|
      if @game_article && @article && @game_article.update(game_article_params) && @article.update(article_params)
        format.html { redirect_to admin_game_article_path(@game, @game_article),
                      notice: 'Article was successfully updated.'
                    }
        format.json { render :show, status: :ok, location: [@game, @game_article] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @game_article
      @game_article.destroy!

      respond_to do |format|
        format.html { redirect_to admin_games_path, notice: 'Article was successfully deleted.' }
        format.json { head :no_content }
      end
    else
      redirect_to admin_games_path, alert: 'Game Article not found.'
    end
  end

  private

  def find_game
    @game = Game.find(params[:game_id])
  end

  def find_game_article
    @game_article = @game.game_articles.find_by(id: params[:id])
  end

  def article_params
    params.require(:game_article).require(:article).permit(:title, :content)
  end

  def game_article_params
    params.require(:game_article).permit(:article_type)
  end
end
