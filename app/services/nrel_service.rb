class NrelService
  def initialize
    @connection = Faraday.new("https://developer.nrel.gov/api/")
    @connection.params["api_key"] = ENV["nrel_key"]
  end

  def get_ten_closest_stations(zip)
    response = @connection.get "alt-fuel-stations/v1/nearest.json" do |req|
      req.params["fuel_type_code"] = ["ELEC," "LPG"]
      req.params["location"] = zip
      req.params["radius"] = 6
      req.params["limit"] = 10
    end
    JSON.parse(response.body)["fuel_stations"].map do |station|
      "#{station["station_name"]}, #{station["street_address"]}, #{station["state"]}, #{station["state"]}, #{station["zip"]},
      Fuel type: #{station["fuel_type_code"]}, Distance: #{station["distance"]} miles, Access times: #{station["access_days_time"]}"
    end
  end

  def get_stations_by_distance(zip, distance)
    response = @connection.get "alt-fuel-stations/v1/nearest.json" do |req|
      req.params["location"] = zip
      req.params["radius"] = distance
    end

    JSON.parse(response.body)["fuel_stations"].map do |station|
      "#{station["station_name"]}, #{station["street_address"]}, #{station["state"]}, #{station["state"]}, #{station["zip"]},
      Fuel type: #{station["fuel_type_code"]}, Distance: #{station["distance"]} miles, Access times: #{station["access_days_time"]}"
    end
  end

    private
    def parse(response)
      JSON.parse(response)
    end

  end
