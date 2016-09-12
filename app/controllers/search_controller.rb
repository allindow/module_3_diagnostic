
class SearchController < ApplicationController
  def index
    @connection = Faraday.new("https://developer.nrel.gov/api/")
    @connection.params["api_key"] = ENV["nrel_key"]
    x = get_10_closest(params[:q])
    require "pry"; binding.pry
  end

  def get_10_closest(params)
    response = @connection.get do |req|
      req.params["location"] = params
      req.params["radius"] = 6
      req.params["limit"] = 10
      req.params["fuel_type_code"] = ["ELEC", "LPG"]
    end
  end


end
