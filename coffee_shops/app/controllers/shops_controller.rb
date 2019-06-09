class ShopsController < ApplicationController

  def index
    render json: Shop.all
  end

  def show
    render json: Shop.find(params["id"])
  end

  def create
    render json: Shop.create(params["shops"])
  end

end
