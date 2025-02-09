# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        authorize! :index, current_user
        render json: User.all
        @users = User.all.order("#{params[:order_by]} #{params[:order_type]}")
        @pagy, @users = pagy(@users, page: params[:page], items: params[:per_page])
        render json: {
          respBody: @users,
          metaData: {
            current_page_count: @pagy.items,
            current_page: @pagy.page,
            total_count: @pagy.count
          }
        }
      end

      def show
        authorize! :show, @user
        render json: @user
      end

      def update
        authorize! :update, @user
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:id])
        authorize! :destroy, @user
        if @user.destroy
          render json: { data: 'User deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      rescue ActiveRecord::RecordNotFound
        render json: { data: 'User not found', status: 'failed' }
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { data: 'User not found', status: 'failed' }, status: :not_found
      end

      def login_params
        params.permit(:id, :password)
      end

      # Only allow a list of trusted parameters through.
      def user_params
        params.require(:user).permit(:name, :age, :phone_no, :password, :role_id)
      end
    end
  end
end
