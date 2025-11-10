class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # The create method creates a new user.
  # It takes the username as a parameter.
  # Returns the created user and a token.
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username' }
    end
  end

  # The login method logs in a user.
  # It takes the username as a parameter.
  # Returns the user and a token.
  def login
    @user = User.find_by(username: params[:username])

    if @user
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, token: token }
    else
      render json: { error: 'Invalid username' }
    end
  end

  # The b_admin method makes a user an admin.
  # It takes the id of the user as a parameter.
  # Returns a message indicating that the user is now an admin.
  def b_admin
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    render json: { message: 'User is now an admin you can test the houses endpoint now.' }
  end

  private

  def user_params
    params.permit(:username)
  end
end
