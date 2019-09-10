require "httparty"
require "dotenv"
require "awesome_print"

Dotenv.load

seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]

URL = "https://us1.locationiq.org/v1/search.php"
TOKEN = ENV["LOCATION_IQ_TOKEN"]

def get_locations(places)
  locations = {}
  
  places.each do |place|
    response = HTTParty.get(URL, query: { q: place, key: TOKEN, format: "json" })
    
    if response.code == 200
      locations[place] = {"lat"=>response.first["lat"].to_f, "lon"=>response.first["lon"].to_f}
    else
      locations[place] = {"lat"=>nil, "lon"=>nil}
    end
  end
  
  sleep(1)
  
  return locations
end
