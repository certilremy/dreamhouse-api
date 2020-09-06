class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[update destroy]
  before_action :require_same_user, only: %i[update]

  def index
    @favorites = if current_user.admin == true
                   Favorite.all
                 else
                   current_user.favorites
                 end
    render json: { favorites: @favorites }
  end

  def update
    if @favorite.update(favorite_params)
      render json: { message: 'Favorite was successfully updated!' }
    else
      render json: { error: 'Error updating the favorite' }
    end
  end

  def destroy
    @favorite.destroy
    render json: { 'message' => 'favorite was successfully deleted' }.to_json
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def favorite_params
    params.require(:favorite).permit(:house_id)
  end

  def require_same_user
    render json: { error: "You're not alowed to peform this operation" } if current_user != @favorite.user && current_user.admin == false
  end
end
