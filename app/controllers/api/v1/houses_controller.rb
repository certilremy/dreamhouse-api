class Api::V1::HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy favorite]
  before_action :require_admin, except: %i[show index favorite]
  before_action :authorized, exept: [:home]

  # The home method is the app welcome page.
  # No parameters are taken.
  # Returns a welcome message.
  def home
    render json: { message: 'Welcome please use our Documentation to start making request' }
  end

  # The index method returns all houses.
  # No parameters are taken.
  # Returns a list of all houses.
  def index
    @houses = House.all
    render json: { houses: @houses }
  end

  # The show method returns a house by id.
  # It takes the id of the house as a parameter.
  # Returns a house.
  def show
    render json: { house: @house }
  end

  # The create method creates a new house.
  # It takes the name, description, price, and user_id as parameters.
  # Returns the created house.
  def create
    @house = House.new(house_params)
    if @house.save
      render json: { house: @house }
    else
      render json: { error: 'Error saving the house' }
    end
  end

  # The favorite method adds a house to the user's favorites.
  # It takes the id of the house as a parameter.
  # Returns a message indicating that the house was added to the user's favorites.
  def favorite
    @favorite = Favorite.create(user_id: current_user.id, house_id: @house.id)
    render json: { message: 'House was successfully added to your favorite!' }
  end

  # The update method updates a house.
  # It takes the id of the house as a parameter.
  # Returns the updated house.
  def update
    if @house.update(house_params)
      render json: { house: @house }
    else
      render json: { error: 'Error updating the house' }
    end
  end

  # The destroy method deletes a house.
  # It takes the id of the house as a parameter.
  # Returns a message indicating that the house was deleted.
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
