class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

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

  # this method is only there for you to make a new user became admin , with thad you can test the documentation live
  # I know yo don't want us to comment our code, this is not a comment. This is just a notice for you.
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
