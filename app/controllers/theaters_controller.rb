# frozen_string_literal: true

class TheatersController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @theaters = Theater.all

    render json: @theaters
  end

  def show
    render json: @theater
  end

  def create
    @theater = Theater.new(group_params)

    if @theater.save
      render json: @theater, status: :created, location: @theater
    else
      render json: @theater.errors, status: :unprocessable_entity
    end
  end

  def update
    if @theater.update(group_params)
      render json: @theater
    else
      render json: @theater.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @theater.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @theater = Theater.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:theater).permit(:name, :location, :city)
  end
end
