class Admin::HomesController < ApplicationController

  def top
    # 会員名と注文個数を表示するための基準が未達成
    # @order_details = Order_detail.all
    # @order_name = Customer.all
    @orders = Order.all
  end
end