# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# initialize the map on the 'map' div
# with the given map ID, center, and zoom
ready = ->

  L.mapbox.accessToken = 'pk.eyJ1IjoicmVuZW1leWUiLCJhIjoiNDNVQnFlSSJ9.AVMZSz8I4zp7qYWfNhHmAg'
  map = L.mapbox.map('map', 'renemeye.6bc642c5').setView [52.1195724, 11.6291814], 15

  $.ajax
    dataType: 'text'
    url: '/agile_pois.json'
    success: (data) ->
      #geojson = $.parseJSON(data)
      #map.featureLayer.setGeoJSON(geojson)
      points = $.parseJSON(data)
      L.circle([point.geometry.coordinates[1], point.geometry.coordinates[0]], 10,point.properties.circle_options).addTo(map) for point in points

  map.on 'click', (ev) ->
    coordinates = ev.latlng
    Turbolinks.visit "/agile_pois/new?latitude=#{coordinates.lat}&longitude=#{coordinates.lng}"

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      map.setView [position.coords.latitude, position.coords.longitude], 15
    , (error) -> {}

  document.getElementById('add').onclick = () ->
    L.marker(map.getCenter()).addTo map

 $(document).ready(ready)
 $(document).on('page:load', ready)
