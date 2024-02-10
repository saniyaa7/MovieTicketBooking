# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_group, only: %i[show update destroy]
  skip_before_action :authorized, only: %i[create login]

  def index
    @users = User.all

    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(group_params)

    if @user.save
      @token = encode_token(user_id: @user.id)
      render json: {
        user: @user,
        token: @token
      }, status: :created

    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by!(id: login_params[:id])
    if @user.authenticate(login_params[:password])
      @token = encode_token(user_id: @user.id)
      render json: {
        user: @user,
        token: @token
      }, status: :accepted
    else
      render json: { message: 'Incorrect password' }, status: :unauthorized
    end
  end

  def update
    if @user.update(group_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @user = User.find(params[:id])
  end

  def login_params
    params.permit(:id, :password)
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:user).permit(:name, :age, :phone_no, :password, :role_id)
  end
end
