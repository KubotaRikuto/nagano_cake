class Public::CartItemsController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.all
  end

  def create
    # binding.pry

    # カートに表示 (商品idから参照)
    # @item = Item.find(cart_item_params[:item_id]) # 結果同じ？ cart_item_params[:item_id] = item_params[id]

    @cart_item = current_customer.cart_items.new(cart_item_params)
    # @cart_item.customer_id = current_customer.id
    @cart_items = current_customer.cart_items.all
    if @cart_items.find_by(item_id: params[:cart_item][:item_id] )
      cart_item = @cart_items.find_by(item_id: params[:cart_item][:item_id] )
      p cart_item
      cart_item.amount += params[:cart_item][:amount].to_i
      p cart_item
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
    @cart_item = current_customer.cart_items.find(cart_item_params[:item_id])
    if @cart_item.update(cart_item_params)
      flash[:notice] = "cart_items was successfully updated."
      redirect_to :index
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
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end

end
