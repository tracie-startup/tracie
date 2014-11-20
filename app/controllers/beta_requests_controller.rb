class BetaRequestsController < ApplicationController
  before_action :set_beta_request, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @beta_requests = BetaRequest.all
    respond_with(@beta_requests)
  end

  def show
    respond_with(@beta_request)
  end

  def new
    @beta_request = BetaRequest.new
    respond_with(@beta_request)
  end

  def edit
  end

  def create
    @beta_request = BetaRequest.new(beta_request_params)
    @beta_request.save
    respond_with(@beta_request)
  end

  def update
    @beta_request.update(beta_request_params)
    respond_with(@beta_request)
  end

  def destroy
    @beta_request.destroy
    respond_with(@beta_request)
  end

  private
    def set_beta_request
      @beta_request = BetaRequest.find(params[:id])
    end

    def beta_request_params
      params.require(:beta_request).permit(:email)
    end
end
