# frozen_string_literal: true

class MovieShowsController < ApplicationController
  before_action :set_group, only: %i[show update destroy]
  
  def index
    @movieshows = MovieShow.all

    render json: @movieshows, each_serializer: MovieShowSerializer
  end

  def show
    render json: @movieshow, serializer: MovieShowSerializer
  end

  def create
    @movieshow = MovieShow.new(group_params)
    
  
    debugger

    if @movieshow.check_date && @movieshow.save
      render json: @movieshow, status: :created, location: @movieshow
    else
      render json: @movieshow.errors, status: :unprocessable_entity
    end
  end

  def update
    if @movieshow.update(group_params)
      render json: @movieshow
    else
      render json: @movieshow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @movieshow.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @movieshow = MovieShow.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:movie_show).permit(:language, :seat_count, :show_start_time, :show_end_time, :screen_no,
                                       :movie_id, seat_type: {})
  end
end
