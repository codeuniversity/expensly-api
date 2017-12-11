class Categories::ArticlesController < ArticlesController
  before_action :set_category

  private

  def set_category
    @category = Category.find(params[:category_id])
    render json: {error: 'not allowed'}, status: 401 unless @category.user == @current_user
  end
end
