class LandingpageController < ApplicationController
  def index
    @beta_request = BetaRequest.new
  end
end
