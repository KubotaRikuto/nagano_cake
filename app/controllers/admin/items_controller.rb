class Admin::ItemsController < ApplicationController

  before_action :select_genres, only: [ :new, :create, :show, :edit, :update ]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      # admin/items/showにリダイレクト
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @item_tax = @item.price*1.1

  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "You have updated item successfully."
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit( :genre_id, :name, :introduction, :price, :is_active [ 1, 0], :item_image )
  end

  def select_genres
    @genres = Genre.all
  end

end
