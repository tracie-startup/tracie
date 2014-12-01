class AgilePoisController < AuthenticatedApplicationController
  before_action :set_agile_poi, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @agile_pois = AgilePoi.where("created_at >= ?", 6.hours.ago.utc)
    respond_with(@agile_pois)
  end

  def map
    unless params[:email] == current_user.email and params[:token] == current_user.authentication_token
      redirect_to "/app?email=#{current_user.email}&token=#{current_user.authentication_token}"
    end
  end

  def show
    respond_with(@agile_poi)
  end

  def new
    @agile_poi = AgilePoi.new
    @agile_poi.latitude = params[:latitude]
    @agile_poi.longitude = params[:longitude]
    respond_with(@agile_poi)
  end

  def edit
  end

  def create
    @agile_poi = AgilePoi.new(agile_poi_params)
    @agile_poi.created_by = current_user
    @agile_poi.save
    respond_with(@agile_poi)
  end

  def update
    @agile_poi.update(agile_poi_params)
    respond_with(@agile_poi)
  end

  def destroy
    @agile_poi.destroy
    respond_with(@agile_poi)
  end

  private
    def set_agile_poi
      @agile_poi = AgilePoi.find(params[:id])
    end

    def agile_poi_params
      params.require(:agile_poi).permit(:title, :description, :latitude, :longitude)
    end
end
