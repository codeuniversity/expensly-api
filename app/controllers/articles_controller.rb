class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :update, :destroy]

  # GET /articles
  def index
    if @category
      @articles = @category.articles
    else
      @articles = @current_user.articles
    end
    @articles = @articles
      .joins(:items)
      .select('articles.*, sum(items.amount * items.price) as cost, count(items.*) as item_count')
      .group('articles.id')
      .order(created_at: :desc)

    render json: @articles
  end

  # GET /articles/1
  def show
    render json: @article
  end

  # POST /articles
  def create
    if @category
      @article = @category.articles.new(article_params)
    else
      @article = Article.new(article_params)
    end
    @article.user = @current_user
    known_article = Article.find_by(name: @article.name)
    render json: known_article and return if known_article != nil
    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /articles/1
  def update
    if @article.update(article_params)
      render json: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /articles/1
  def destroy
    @article.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      render json: {error: 'not allowed'}, status: 401 unless @article.user == @current_user
    end

    # Only allow a trusted parameter "white list" through.
    def article_params
      params.require(:article).permit(:name, :user_id, :category_id)
    end
end
