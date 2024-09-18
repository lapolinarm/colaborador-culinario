class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    if current_user.owner?
      @restaurants = current_user.restaurants
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant), notice: "Restaurant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to restaurant_path(@restaurant), notice: "Restaurant was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    redirect_to restaurants_path, status: :see_other
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:ruc, :commercial_name, :company_name, :phone, :mobile_phone, :address, :district, :province, :country, :reference, :user_id, :photo)
  end

  def authorize_owner!
    unless current_user.owner?
      redirect_to root_path, alert: 'No tienes permiso para realizar esta acción.'
    end
  end
end
