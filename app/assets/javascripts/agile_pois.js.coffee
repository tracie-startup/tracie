# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# initialize the map on the 'map' div
# with the given map ID, center, and zoom
ready = ->

  L.mapbox.accessToken = 'pk.eyJ1IjoicmVuZW1leWUiLCJhIjoiNDNVQnFlSSJ9.AVMZSz8I4zp7qYWfNhHmAg'
  map = L.mapbox.map('map', 'renemeye.6bc642c5').setView [52.1195724, 11.6291814], 16
  myPositionLayer = L.mapbox.featureLayer().addTo(map)
  addNewMarker = null
  agile_pois = null

  go_to_my_location = ->
    if navigator.geolocation
      map.locate()

  $latitude = $('.new-apoi-form input[name="agile_poi[latitude]"]')
  $longitude = $('.new-apoi-form input[name="agile_poi[longitude]"]')
  setLatLngNewApoiForm = (latitude, longitude)->
    $latitude.val("#{latitude}")
    $longitude.val("#{longitude}")

  load_agile_pois = ->
    agile_pois = new L.FeatureGroup()
    map.addLayer(agile_pois)
    $.ajax
      dataType: 'text'
      url: '/agile_pois.json'
      success: (data) ->
        points = $.parseJSON(data)
        L.circle([point.geometry.coordinates[1], point.geometry.coordinates[0]], 10,point.properties.circle_options).addTo(agile_pois) for point in points

  redraw_agile_pois = ->
    map.removeLayer(agile_pois)
    load_agile_pois()

  #Center map to current location
  go_to_my_location()

  #load aPOIs
  load_agile_pois()

  # map.on 'click', (ev) ->
  #   coordinates = ev.latlng
  #   Turbolinks.visit "/agile_pois/new?latitude=#{coordinates.lat}&longitude=#{coordinates.lng}"
  newTraciebleForm = $(".new-apoi-form")

  $('#goto_my_location').click (e) ->
    e.preventDefault()
    go_to_my_location()

  $('#add_apoi_marker').click (e) ->
    e.preventDefault()
    newTraciebleForm.addClass("open")
    addNewMarker = L.marker(map.getCenter(),
      draggable: true
    ).addTo(map)
    setLatLngNewApoiForm(addNewMarker._latlng.lat, addNewMarker._latlng.lng)
    addNewMarker.on 'move', ->
      setLatLngNewApoiForm(@_latlng.lat, @_latlng.lng)

  $('#cancel_add_apoi').click (e) ->
    e.preventDefault()
    newTraciebleForm.removeClass("open")
    clearNewApoiForm()
    map.removeLayer(addNewMarker)

  $('#submit_agile_poi').click (e) ->
    e.preventDefault()
    newTraciebleForm.removeClass("open")
    saveAgilePOI $(".new-apoi-form .new_agile_poi").serializeObject(), ->
      clearNewApoiForm()
      map.removeLayer(addNewMarker)
      redraw_agile_pois()

  map.on "locationfound", (e) ->
    map.fitBounds e.bounds
    myPositionLayer.setGeoJSON
      type: "Feature"
      geometry:
        type: "Point"
        coordinates: [
          e.latlng.lng
          e.latlng.lat
        ]
      properties:
        title: "Here I am!"
        "marker-color": "#5fa4ff"
        "marker-symbol": "circle"
    # And hide the geolocation button
    return



#Ready for Turbolinks
$(document).ready(ready)
$(document).on('page:load', ready)


##Helper
saveAgilePOI = (data, callback) ->
  console.log("foobar")
  $.ajax
    type: "POST"
    dataType: "json"
    url: "/agile_pois.json"
    data: data
    success: callback

$.fn.serializeObject = ->
  parsed = {}
  a = this.serializeArray()
  $.each a, ->
    if /[^\[]+\[[^\[]+\]/.test @name    #Parse content with names like agile_poi[title]
      slice = /^([^\[]+)\[([^\[]+)\]/.exec @name
      form_group = slice[1]
      form_name = slice[2]
      if parsed[form_group] is undefined
        parsed[form_group] = {}
      if parsed[form_group][form_name] == undefined
        parsed[form_group][form_name] = @value || ''
      else
        unless parsed[form_group][form_name].push
          parsed[form_group][form_name] = [parsed[form_group][form_name]]
        parsed[form_group][form_name].push(@value || '')
    else  #Parse content with normal names
      if parsed[@name] == undefined
        parsed[@name] = @value || ''
      else
        unless parsed[@name].push
          parsed[@name] = [parsed[@value]]
        parsed[@name].push(@value || '')
  return parsed

clearNewApoiForm = ->
  $('.new-apoi-form input[name^="agile_poi"]').val("")

# Reads paramter from URL
# getParameterByName = (name) ->
#   name = name.replace(/[\[]/,"\\[").replace(/[\]]/,"\\]")
#   regex = new RegExp("[\\?&]#{name}=([^&#]*)")
#   results = regex.exec(location.search)
#   return "" unless results
#   decodeURIComponent results[1].replace(/\+/g," ")
