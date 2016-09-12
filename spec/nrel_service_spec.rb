require 'rails_helper'

describe "nrel service" do
  context "#search" do
    it "filters on parameters by zip code closest 10" do
      VCR.use_cassette("zip 80203") do
        connection = Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?api_key=#{ENV['nrel_key']}&location=80203&radius=6&limit=10&fuel_type_code=['ELEC', 'LPG']")
        stations_array = JSON.parse(connection.body)["fuel_stations"]
        expect(stations_array.count).to eq(10)
        expect(stations_array.first["station_name"]).to eq("UDR")
        expect(stations_array.first["distance"]).to eq(0.3117)
        expect(stations_array.last["station_name"]).to eq("Hyatt Regency Denver")
        expect(stations_array.last["distance"]).to eq(1.03475)
      end
    end
  end
end
