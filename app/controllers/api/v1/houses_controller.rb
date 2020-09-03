class Api::V1::HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy favorite]
  before_action :require_admin, except: %i[show index favorite]
  def index
    @houses = House.all
    render json: { houses: @houses }
  end

  def show
    render json: { house: @house }
  end

  def create
    @house = House.new(house_params)
    if @house.save
      render json: { house: @house }
    else
      render json: { error: 'Error saving the house' }
    end
  end

  def favorite
    @favorite = Favorite.create(user_id: current_user.id, house_id: @house.id)
    render json: { message: 'House was successfully added to your favorite!' }
  end

  def update
    if @house.update(house_params)
      render json: { house: @house }
    else
      render json: { error: 'Error updating the house' }
    end
  end

  def destroy
    @house.destroy
    render json: { 'message' => 'House was successfully deleted' }.to_json
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:name, :description, :price, :user_id)
  end

  def require_admin
    render json: { error: "You're not alowed to perform this operation" } if current_user.admin == false
  end
end
