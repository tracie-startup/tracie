class LandingpageController < ApplicationController
  def index
    @beta_request = BetaRequest.new
  end

  def impressum

  end

  def details
    @beta_request = BetaRequest.new
  end
end
