class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /categories
  def index
    if @parent_category
      @categories = @parent_category.categories
    else
      @categories = @current_user.categories
    end
    render json: @categories
  end

  # GET /categories/1
  def show
    render json: @category
  end

  # POST /categories
  def create
    if @parent_category
      @category = @parent_category.categories.new(category_params)
    else
      @category = Category.new(category_params)
    end
    @category.user = @current_user
    known_category = Category.find_by(name: @category.name)

    render json: known_category and return if known_category != nil

    if @category.save
      render json: @category, status: :created, location: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      render json: @category
    else
      render json: @category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      render json: {error: 'not allowed'}, status: 401 unless @category.user == @current_user
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :catagory_id)
    end
end
