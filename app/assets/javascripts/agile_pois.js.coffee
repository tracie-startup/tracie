# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# initialize the map on the 'map' div
# with the given map ID, center, and zoom
# ready = ->
#   $.ajax
#     dataType: 'text'
#     url: '/agile_pois.json'
#     success: (data) ->
#       #geojson = $.parseJSON(data)
#       #map.featureLayer.setGeoJSON(geojson)
#       points = $.parseJSON(data)
#       L.circle([point.geometry.coordinates[1], point.geometry.coordinates[0]], 10,point.properties.circle_options).addTo(map) for point in points
#
#   map.on 'click', (ev)->
#     coordinates = ev.latlng
#     Turbolinks.visit "/agile_pois/new?latitude=#{coordinates.lat}&longitude=#{coordinates.lng}"
#
# $(document).ready(ready)
# $(document).on('page:load', ready)
