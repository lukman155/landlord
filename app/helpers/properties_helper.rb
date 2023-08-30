module PropertiesHelper
  def haversine_distance(lat1, lon1)
    earth_radius_km = 6371.0 # Earth's radius in kilometers
  
    # Convert degrees to radians
    lat1_rad = deg_to_rad(lat1)
    lon1_rad = deg_to_rad(lon1)
    lat2_rad = deg_to_rad(11.152935836039392)
    lon2_rad = deg_to_rad(7.654472978879806)
  
    # Haversine formula
    dlat = lat2_rad - lat1_rad
    dlon = lon2_rad - lon1_rad
  
    a = Math.sin(dlat / 2) ** 2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon / 2) ** 2
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  
    distance = sprintf("%.2f", (earth_radius_km * c))
    distance
  end
  
  def deg_to_rad(degrees)
    degrees * Math::PI / 180
  end
end
