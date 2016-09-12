class Stations < OpenStruct
  def self.service
    NrelService.new
  end

  def self.ten_closest_stations(zip)
    stations = service.get_ten_closest_stations(zip)
  end
end
