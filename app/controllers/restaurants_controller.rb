class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:show, :update, :destroy]
  # GET /restaurants
  def index
    restaurants = Restaurant.all
    render_json(restaurants)
  end

  # GET /restaurants/:id
  def show
    render_json(@restaurant)
  end

  # POST /restaurants
  def create
    # create! RecordInvalid exception handled in ApplicationController
    Restaurant.create!(restaurant_params)
  end

  # PUT /restaurants/:id
  def update
    # update! RecordInvalid exception handled in ApplicationController
    @restaurant.update!(restaurant_params)
  end

  # DELETE /restaurants/:id
  def destroy
    if @restaurant.destroy
      head :ok
    else
      render_json(restaurant.errors.messages, :internal_server_error)
    end
  end

  private


  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.permit(:name, :rating, :accept10bis,
                  :max_delivery_time_min, :address,
                  :latitude, :longitude, :cuisine)
  end
end
