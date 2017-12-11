class Articles::ItemsController < ItemsController
  before_action :set_article


  private
  def set_article
    @container = Article.find(params[:article_id])
    render json: {error: 'not allowed'}, status: 401 unless @container.user == @current_user
  end
  end
