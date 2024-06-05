class GroundsController < ApplicationController
  def index
    @grounds = Ground.published
  end
end
