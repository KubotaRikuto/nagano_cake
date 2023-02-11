class Public::HomesController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(top,aboutは除く)
  before_action :authenticate_customer!, except: [:top, :about]

  def top
    @items = Item.order('id DESC').limit(4)
  end

  def about

  end
end
