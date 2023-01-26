class Public::CartItemsController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
    # @cart_item_price_sum += @cart_item.subtotal
  end

  def create
    # binding.pry

    # カートに表示 (商品idから参照)
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_items = current_customer.cart_items.all

    if @cart_items.find_by(item_id: params[:cart_item][:item_id] )
      cart_item = @cart_items.find_by(item_id: params[:cart_item][:item_id] )
      # p cart_item # p ~ :ログ確認の記述
      cart_item.amount += params[:cart_item][:amount].to_i
      # p cart_item
      cart_item.save
      redirect_to cart_items_path

    elsif @cart_item.save
      flash[:notice] = "cart_items was successfully created."
      redirect_to cart_items_path

    else
      @cart_items = current_customer.cartitems.all
      flash[:notice] = "cart_items was false created."
      render :index
    end
  end

  def update
    @cart_item = current_customer.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "cart_items was successfully updated."
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items.all
      render :index
    end
  end

  def destroy
    @cart_item = current_customer.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
