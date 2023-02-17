class Admin::OrderDetailsController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト(adminは例外なし)
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    # binding.pry
    @order_details = @order.order_details
    if @order_detail.update(order_detail_params)

    # binding.pry
      # 制作ステータスが一つでも製作中なら注文ステータスを製作中に更新
      if @order_details.where(making_status: "making_progress").count >= 1
        @order_detail.order.update(status: "under_making")

      # 制作ステータスが全て製作完了なら注文ステータスを発送準備中に更新
      elsif @order_details.count == @order_details.where(making_status: "completed").count
        # binding.pry
        @order_detail.order.update(status: "preparing_to_ship")
      end

      flash[:notice] = "You have updated making_status successfully."
      redirect_to admin_order_path(@order_detail.order.id)
    else
      flash[:notice] = "You have updated making_status false."
      redirect_to admin_order_path(@order_detail.order.id)
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
