class Public::ItemsController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  before_action :authenticate_customer!

  def index
  end

  def show
  end
end
