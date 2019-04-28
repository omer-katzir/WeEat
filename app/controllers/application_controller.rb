class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def unprocessable_response(exception)
    render_json(exception.record.errors, :unprocessable_entity)
  end

  def render_not_found(exception)
    render_json(exception.message, :not_found)
  end

  protected

  def render_json(object, status = :ok)
    render json: object, status: status
  end

end
