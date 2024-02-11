# frozen_string_literal: true
module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_group, only: %i[show update destroy]
      skip_before_action :authorized, only: %i[create login]

      def index
        authorize! :index, @user
        @users = User.all
        render json: @users
      end

      def show
        authorize! :show, @user
        render json: @user
      end

      def create
        @user = User.new(user_params)
        role = Role.find(@user.role_id)
      
        if @user.save
          @token = encode_token({ user_id: @user.id })  # Ensure correct format of the payload
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
        authorize! :update, @user
        if @user.update(group_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @user
        if @user.destroy!
        render json: { data: 'User deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_group
        @user = User.find(params[:id])
        unless @user
          render json: { data: 'Ticket not found', status: 'failed' }
        end
      end

      def login_params
        params.permit(:id, :password)
      end

      # Only allow a list of trusted parameters through.
      def group_params
        params.require(:user).permit(:name, :age, :phone_no, :password, :role_id)
      end
    end
  end
end
