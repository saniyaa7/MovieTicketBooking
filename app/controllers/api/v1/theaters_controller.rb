# frozen_string_literal: true

module Api
  module V1
    class TheatersController < ApplicationController
      before_action :set_group, only: %i[show update destroy]

      def index
        authorize! :index, Theater
        @theaters = Theater.all

        render json: @theaters
      end

      def show
        authorize! :show, @theater
        render json: @theater
      end

      def create
        @theater = Theater.new(group_params)
        authorize! :create, @theater

        if @theater.save
          render json: @theater, status: :created, location: api_v1_theater_url(@theater)
        else
          render json: @theater.errors, status: :unprocessable_entity
        end
      end

      def update
        authorize! :update, @theater
        if @theater.update(group_params)
          render json: @theater
        else
          render json: @theater.errors, status: :unprocessable_entity
        end
      end

      def destroy
        authorize! :destroy, @theater
        if @theater.destroy
          render json: { data: 'Theater Show deleted successfully', status: 'success' }
        else
          render json: { data: 'Something went wrong', status: 'failed' }
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_group
        @theater = Theater.find(params[:id])
        return if @theater

        render json: { data: 'Theater not found', status: 'failed' }
      end

      # Only allow a list of trusted parameters through.
      def group_params
        params.require(:theater).permit(:name, :location, :city)
      end
    end
  end
end
