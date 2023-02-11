class Admin::HomesController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト
  before_action :authenticate_admin!

  def top
    @orders = Order.all
  end
end