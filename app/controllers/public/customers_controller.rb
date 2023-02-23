class Public::CustomersController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  before_action :authenticate_customer!
  # before_action :is_matching_login_user, only: [:edit, :update]


  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "You have updated my page successfully."
      redirect_to customers_my_page_path
    else
      flash[:notice] = "You have updated my page failed."
     render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdrawl
    @customer = current_customer
    @customer.update(is_deleted: true)

    #sessionIDのresetを行う
    reset_session
    #指定されたrootへのpath
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

  # def is_matching_login_user
  #   user_id = params[:id].to_i
  #   login_user_id = current_customer.id
  #   if (user_id != login_user_id )
  #     redirect_to new_customer_session_path
  #   end
  # end

end
