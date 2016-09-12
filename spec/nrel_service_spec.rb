require 'rails_helper'

describe "nrel service" do
  context "#search" do
    it "filters on parameters by zip code" do
      VCR.use_cassette("zip 80203") do
        connection = Faraday.get("https://developer.nrel.gov/api/")
        stations_array = JSON.parse(get_10_closest(params[:q]).body)["fuel_stations"]
        require "pry"; binding.pry
      end
    end
  end
end
