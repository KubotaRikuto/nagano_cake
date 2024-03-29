class Public::ItemsController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  # before_action :authenticate_customer!
  before_action :select_genres, only: [:index, :show ]

  def index
    @items = Item.page(params[:page]).per(8)
    @item_count = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private

  def item_params
    params.require(:item).permit( :genre_id, :name, :introduction, :price, :is_active [ 1, 0], :item_image )
  end

  def select_genres
    @genres = Genre.all
  end

end
