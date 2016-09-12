
class SearchController < ApplicationController
  def index
    @stations = Stations.ten_closest_stations(params[:q]) if params[:d].empty?
    @stations = Stations.stations_by_distance(params[:q], params[:d])
    require "pry"; binding.pry
  end
end
