class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /items
  def index
    if @transaction
      @items = @transaction.items
    else
      @items = @current_user.items
    end
    @items = @items.select('items.*, items.amount * items.price as cost')
      .joins(:article => :category)
      .order('categories.name ASC, cost DESC' )
    render json: @items
  end

  # GET /items/1
  def show
    render json: @item
  end

  # POST /items
  def create
    if @transaction
      @item = @transaction.items.new(item_params)
    else
      @item = Item.new(item_params)
    end
      @item.user = @current_user
    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      render json: {error: 'not allowed'}, status: 401 unless @item.user == @current_user

    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:price, :transaction_id, :article_id, :amount)
    end
end
