class Categories::CategoriesController < CategoriesController
  before_action :set_parent_category

  private

  def set_parent_category
    @parent_category = Category.find(params[:category_id])
    render json: {error: 'not allowed'}, status: 401 unless @category.user == @current_user
  end
  end
