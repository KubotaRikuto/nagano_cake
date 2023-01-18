class Admin::CustomersController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト(adminは例外なし)
  before_action :authenticate_admin!

  def index
  end

  def show
  end

  def edit
  end

  def update
  end
end
