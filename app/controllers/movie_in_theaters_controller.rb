# frozen_string_literal: true

class MovieInTheatersController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @movie_in_theaters = MovieInTheater.all

    render json: @movie_in_theaters
  end

  def show
    render json: @movie_in_theater
  end

  def create
    @movie_in_theater = MovieInTheater.new(group_params)

    if @movie_in_theater.save
      render json: @movie_in_theater, status: :created, location: @movie_in_theater
    else
      render json: @movie_in_theater.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movie_in_theater.update(group_params)
      render json: @movie_in_theater
    else
      render json: @movie_in_theater.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movie_in_theater.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @movie_in_theater = MovieInTheater.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:movie_in_theater).permit(:movie_show_id, :theater_id)
  end
end
