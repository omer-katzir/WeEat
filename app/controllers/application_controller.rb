class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def unprocessable_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

end
