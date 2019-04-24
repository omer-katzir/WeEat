class RestaurantsController < ApplicationController
  # GET /restaurants
  def index
    @restaurants = Restaurant.all
    render_json(@restaurants)
  end

  # GET /restaurants/:id
  def show
    @restaurant = Restaurant.find(params[:id]) #throws :not_found exception
    render_json(@restaurant)
  end

  def new
    @restaurant = Restaurant.new
    render_json(@restaurant)
  end

  # POST /restaurants
  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render_json(@restaurant.as_json, :created)
    else
      render_json(@restaurant.errors.messages, :bad_request)
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id]) #throws :not_found exception
    render_json(@restaurant)
  end

  # PUT /restaurants/:id
  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      head :ok
    else
      render_json(@restaurant.errors.messages, :bad_request)
    end

  end

  # DELETE /restaurants/:id
  def delete
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.delete
     head :ok
    else
      render_json(@restaurant.errors.messages, :internal_server_error)
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy
      head :ok
    else
      render_json(@restaurant.errors.messages, :internal_server_error)
    end
  end

  private

  def restaurant_params
    params.permit(:name, :rating, :b10bis,
                  :max_delivery_time, :address,
                  :latitude, :longitude, :cuisine)
  end

  def render_json(object , status = :ok)
    render json: object.as_json, status: status
  end
end
