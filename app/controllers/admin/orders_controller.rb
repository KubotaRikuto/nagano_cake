class Admin::OrdersController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト(adminは例外なし)
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @customer = @order.customer
    @customer_name = @customer.last_name + @customer.first_name
    @order_details = @order.order_details
    @order_item_total_price = 0
    @order_details.each do |order_detail|
      @order_item_total_price += order_detail.subtotal
    end
  end

  def update
    @order = Order.find(params[:id])
    @order_detail = @order.order_details
    if @order.update(order_params)
      if @order.status == "payment_confirmation"
        @order_detail.each do |order_detail|
          # binding.pry
          order_detail.update(making_status: "waiting_making")
        end
      end
      flash[:notice] = "You have updated order status successfully."
      redirect_to admin_order_path(@order.id)
    else
      redirect_to admin_order_path(@order.id)
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
