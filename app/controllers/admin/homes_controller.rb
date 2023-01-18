class Admin::HomesController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト
  before_action :authenticate_admin!

  def top
    # 会員名と注文個数を表示するための基準が未達成
    # @order_details = Order_detail.all
    # @order_name = Customer.all
    @orders = Order.all
  end
end