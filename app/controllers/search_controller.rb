
class SearchController < ApplicationController
  def index
    @connection = Faraday.new("https://developer.nrel.gov/api/")
    stations_array = JSON.parse(get_10_closest(params[:q]).body)["fuel_stations"]
    @stations = stations_array.map do |station|
      "#{station["station_name"]}, #{station["street_address"]}, #{station["state"]}, #{station["state"]}, #{station["zip"]},
      Fuel type: #{station["fuel_type_code"]}, Distance: #{station["distance"]} miles, Access times: #{station["access_days_time"]}"
    end
  end

  def get_10_closest(params)
    response = @connection.get "alt-fuel-stations/v1/nearest.json" do |req|
      req.params["api_key"] = ENV["nrel_key"]
      req.params["fuel_type_code"] = ["ELEC," "LPG"]
      req.params["location"] = params
      req.params["radius"] = 6
      req.params["limit"] = 10
    end
  end


end
