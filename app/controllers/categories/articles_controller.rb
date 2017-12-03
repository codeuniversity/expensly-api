class Categories::ArticlesController < ArticlesController
  before_action :set_category

  private

  def set_category
    @category = Category.find(params[:category_id])
  end
end
