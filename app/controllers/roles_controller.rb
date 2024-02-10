# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :set_group, only: %i[show update destroy]

  def index
    @roles = Role.all

    render json: @roles
  end

  def show
    render json: @role
  end

  def create
    @role = Role.new(group_params)

    if @role.save
      render json: @role, status: :created, location: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  def update
    if @role.update(group_params)
      render json: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @role.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @role = Role.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:role).permit(:role_name)
  end
end
