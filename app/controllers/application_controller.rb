class ApplicationController < ActionController::Base
  include Pagy::Backend
  if Rails.env.production? || Rails.env.staging?
    rescue_from StandardError, with: :render_500
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private

  def render_404(exception = nil)
    if exception
      logger.error "Rendering 404 with exception"
      logger.error "#{exception.class} (#{exception.message}): #{exception.backtrace.join("\n")}"
    end
    redirect_to not_found_path
  end

  def render_500(exception = nil)
    if exception
      logger.error "Rendering 500 with exception"
      logger.error "#{exception.class} (#{exception.message}): #{exception.backtrace.join("\n")}"
    end
    redirect_to internal_server_error_path
  end
end
