require 'httparty'
require "dotenv"

Dotenv.load

seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

BASE_URL = "https://us1.locationiq.com/v1/search.php"

seven_wonders_locations = seven_wonders.map do |wonder|
  sleep(0.2)
  
  query = { key: ENV["API_TOKEN"], q: wonder, format: "json" }
  
  response = HTTParty.get(BASE_URL, query: query)
  
  begin  
    lat = response[0]["lat"].to_f
    lon = response[0]["lon"].to_f
    [wonder, lat, lon]
    
  rescue NoMethodError
    [wonder, nil, nil]
  end
end

locations_hash = {}

seven_wonders_locations.each do |wonder|
  locations_hash[wonder[0]] = {"lat"=>wonder[1], "lon"=>wonder[2]}
end

puts locations_hash

# Example Output:
#{"Great Pyramind of Giza"=>{"lat"=>29.9792345, "lng"=>31.1342019}, "Hanging Gardens of Babylon"=>{"lat"=>32.5422374, "lng"=>44.42103609999999}, "Colossus of Rhodes"=>{"lat"=>36.45106560000001, "lng"=>28.2258333}, "Pharos of Alexandria"=>{"lat"=>38.7904054, "lng"=>-77.040581}, "Statue of Zeus at Olympia"=>{"lat"=>37.6379375, "lng"=>21.6302601}, "Temple of Artemis"=>{"lat"=>37.9498715, "lng"=>27.3633807}, "Mausoleum at Halicarnassus"=>{"lat"=>37.038132, "lng"=>27.4243849}}

# Actual Output
# {"Great Pyramid of Giza"=>{"lat"=>29.9791264, "lon"=>31.1342383751015}, 
# "Hanging Gardens of Babylon"=>{"lat"=>nil, "lon"=>nil}, 
# "Colossus of Rhodes"=>{"lat"=>36.3397076, "lon"=>28.2003164}, 
# "Pharos of Alexandria"=>{"lat"=>30.94795585, "lon"=>29.5235626430011}, 
# "Statue of Zeus at Olympia"=>{"lat"=>37.6379088, "lon"=>21.6300063}, 
# "Temple of Artemis"=>{"lat"=>40.7801086, "lon"=>24.7147622}, 
# "Mausoleum at Halicarnassus"=>{"lat"=>37.03785995, "lon"=>27.4241280469557}}
