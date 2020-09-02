class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username' }
    end
  end

  def login
    @user = User.find_by(username: params[:username])

    if @user
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username' }
    end
  end

  def auto_login; end

  private

  def user_params
    params.permit(:username)
  end
end
