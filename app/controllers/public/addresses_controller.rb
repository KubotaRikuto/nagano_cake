class Public::AddressesController < ApplicationController
  # ログインしていない場合はサインインにリダイレクト(homes/top,aboutは除く)
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:edit, :update]

  def index
    @customer = current_customer
    @address = Address.new
    @addresses = @customer.addresses.all
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "You have created address successfully."
      redirect_to addresses_path
    else
      @customer = current_customer
      @address = Address.new
      @addresses = @customer.addresses.all
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end

  def is_matching_login_customer
    @address = Address.find(params[:id])
    customer_id = @address.customer.id
    login_customer_id = current_customer.id
    if (customer_id != login_customer_id )
      redirect_to addresses_path
    end
  end

end
