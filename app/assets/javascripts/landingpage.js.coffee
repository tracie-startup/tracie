# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  points_instances = []
  raw_points = []

  #TODO: Free Memory. Circles are only loaded. They arent removed jet
  insertNextPoint = ->
    if raw_points.length
      point = raw_points.pop()
      points_instances.push L.circle([point.geometry.coordinates[1], point.geometry.coordinates[0]], 10,point.properties.circle_options).addTo(test_map)
      setTimeout(insertNextPoint, 300)
    else
      $.ajax
        dataType: 'text'
        url: '/agile_pois.json'
        success: (data) ->
          #geojson = $.parseJSON(data)
          #map.featureLayer.setGeoJSON(geojson)
          raw_points = $.parseJSON(data)
          setTimeout(insertNextPoint,1000)
    for point in points_instances
      if point.options.opacity > 0
        point.setStyle({opacity: point.options.opacity - 0.1, fillOpacity: point.options.fillOpacity - 0.1})

  insertNextPoint()


  # test-map.on 'click', (ev)->
  #   coordinates = ev.latlng
  #   Turbolinks.visit "/agile_pois/new?latitude=#{coordinates.lat}&longitude=#{coordinates.lng}"

$(document).ready(ready)
$(document).on('page:load', ready)
