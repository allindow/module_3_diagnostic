
class SearchController < ApplicationController
  def index
    @stations = Stations.ten_closest_stations(params[:q])
  end
end
