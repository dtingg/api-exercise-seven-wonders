require_relative "test_helper"

describe "get_locations" do
  before do
    VCR.use_cassette("location_find") do
      seven_wonders = ["Great Pyramid of Giza", "Hanging Gardens of Babylon", "Colossus of Rhodes", "Pharos of Alexandria", "Statue of Zeus at Olympia", "Temple of Artemis", "Mausoleum at Halicarnassus"]
      @location_hash = get_locations(seven_wonders)
    end
  end
  
  it "returns a hash" do
    expect(@location_hash).must_be_instance_of Hash
  end
  
  it "finds the correct latitude and longitude" do
    location = "Great Pyramid of Giza"
    lat = @location_hash[location]["lat"]
    lon = @location_hash[location]["lon"]
    
    expect(lat).must_equal 29.9791264
    expect(lon).must_equal 31.1342383751015
  end
  
  it "returns nil if location can't be found" do
    location = "Hanging Gardens of Babylon"
    lat = @location_hash[location]["lat"]
    lon = @location_hash[location]["lon"]
    
    expect(lat).must_be_nil
    expect(lon).must_be_nil
  end
end
