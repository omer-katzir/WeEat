class RestaurantsController < ApplicationController

  # GET /restaurants
  def index
    restaurants = Restaurant.all
    render_json(restaurants)
  end

  # GET /restaurants/:id
  def show
    restaurant = Restaurant.find(params[:id])
    render_json(restaurant)
  end

  # POST /restaurants
  def create
    # create! RecordInvalid exception handled in ApplicationController
    Restaurant.create!(restaurant_params)
  end

  # PUT /restaurants/:id
  def update
    restaurant = Restaurant.find(params[:id])
    # update! RecordInvalid exception handled in ApplicationController
    restaurant.update!(restaurant_params)
  end

  # DELETE /restaurants/:id
  def destroy
    restaurant = Restaurant.find(params[:id])
    if restaurant.destroy
      head :ok
    else
      render_json(restaurant.errors.messages, :internal_server_error)
    end
  end

  private

  def restaurant_params
    params.permit(:name, :rating, :accept10bis,
                  :max_delivery_time_min, :address,
                  :latitude, :longitude, :cuisine)
  end

  def render_json(object, status = :ok)
    render json: object, status: status
  end



end
