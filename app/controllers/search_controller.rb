class SearchController < ApplicationController
  def index
    if params[:d].empty?
      @stations = Stations.ten_closest_stations(params[:q])
    else
    stations_by_distance = Stations.stations_by_distance(params[:q], params[:d])
    @all_stations_by_distance = Kaminari.paginate_array(stations_by_distance).page(params[:page])
    end
  end
end
