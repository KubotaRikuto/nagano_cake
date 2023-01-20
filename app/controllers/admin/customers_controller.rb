class Admin::CustomersController < ApplicationController
  #ログインしていない状態で管理者ページにアクセスすると、ログイン画面へリダイレクト(adminは例外なし)
  before_action :authenticate_admin!
  before_action :is_matching_login_admin_user, only: [:edit, :update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
    @customer_name = @customer.last_name + @customer.first_name
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "You have updated customer successfully."
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted )
  end

  def is_matching_login_admin_user
    admin_user_id = params[:id].to_i
    login_admin_user_id = current_admin.id
    if (admin_user_id != login_admin_user_id )
      redirect_to new_admin_session_path
    end
  end
end
