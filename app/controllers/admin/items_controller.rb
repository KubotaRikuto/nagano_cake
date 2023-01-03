class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @items.update(item_params)
    redirect_to 
  end

  private

  def item_params
    params.require(:item).permit( :genre_id, :name, :introduction, :price, :is_active [:true, :false] )
  end


end
