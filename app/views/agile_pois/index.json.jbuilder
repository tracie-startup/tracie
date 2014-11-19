json.array!(@agile_pois) do |agile_poi|
  json.type 'Feature'
  json.geometry do
    json.type 'Point'
    json.coordinates [agile_poi.longitude, agile_poi.latitude]
  end
  json.properties do
    json.name agile_poi.title
    json.description agile_poi.description
    json.circle_options do
      json.color '#e74c3c'
      json.opacity agile_poi.decay_rate
      json.weight 3
      json.fillColor '#e74c3c'
      json.fillOpacity agile_poi.decay_rate
    end
  end
  # json.extract! agile_poi, :id, :title, :description, :created_by, :posted_by, :decay_rate, :latitude, :longitude
  # json.url agile_poi_url(agile_poi, format: :json)
end
