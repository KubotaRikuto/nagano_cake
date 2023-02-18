class Public::OrdersController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  before_action :authenticate_customer!

  def new
    @order = current_customer.orders.new
    @address = current_customer.addresses
  end

  def confirm
    # ご自身の住所
    if params[:order][:select_address] == "0"
      @order = Order.new(order_params)
      @order.shipping_postal_code = current_customer.postal_code
      @order.shipping_address = current_customer.address
      @order.shipping_name = current_customer.first_name + current_customer.last_name
    # 登録済住所から選択
    elsif params[:order][:select_address] == "1"
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.shipping_postal_code = @address.postal_code
      @order.shipping_address = @address.address
      @order.shipping_name = @address.name
    # 新しいお届け先
    elsif params[:order][:select_address] == "2"
      @order = Order.new(order_params)
    else
      render :new
    end
    # カート内商品
    @cart_items = current_customer.cart_items.all
    # 合計金額(送料抜)
    @order_item_total_price = 0
    @cart_items.each do |cart_item|
      @order_item_total_price += cart_item.subtotal
    end
    # 合計金額(送料込)
    @order.amount_billed = @order_item_total_price + @order.postage
  end

  def create
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items = current_customer.cart_items.all
      # order_detailにcart_item情報保存
      cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.amount = cart_item.amount
        @order_detail.purchase_prise = cart_item.item.with_tax_price.to_s(:delimited)
        @order_detail.save
      end
      # cart_item情報を削除
      current_customer.cart_items.destroy_all
      # サンクス画面に遷移
      flash[:notice] = "order was successfully created."
      redirect_to orders_complete_path
    else
      flash[:notice] = "order was fallsed created."
      redirect_to orders_confirm_path
    end
  end

  def complete
  end

  def index
    @orders = current_customer.orders.page(params[:page]).per(8)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_item_total_price = 0
    @order_item_total_price = @order.amount_billed - @order.postage
  end

  private

  def order_params
    params.require(:order).permit(:shipping_postal_code, :shipping_address, :shipping_name, :amount_billed, :payment_method, :status)
  end

end
