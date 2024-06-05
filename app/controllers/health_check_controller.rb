class HealthCheckController < ApplicationController

  def index
    render json: { healthcheck: 'ok' }
  end
end
