# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# initialize the map on the 'map' div
# with the given map ID, center, and zoom
ready = ->

  ####L.mapbox.accessToken = 'pk.eyJ1IjoicmVuZW1leWUiLCJhIjoiNDNVQnFlSSJ9.AVMZSz8I4zp7qYWfNhHmAg'
  ####map = L.mapbox.map('map', 'renemeye.6bc642c5').setView [52.1195724, 11.6291814], 15
  addNewMarker = null

  #Center map to current location
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      map.setView [position.coords.latitude, position.coords.longitude], 15
    , (error) -> {}

  #load aPOIs
  $.ajax
    dataType: 'text'
    url: '/agile_pois.json'
    success: (data) ->
      points = $.parseJSON(data)
      ####L.circle([point.geometry.coordinates[1], point.geometry.coordinates[0]], 10,point.properties.circle_options).addTo(map) for point in points

  # map.on 'click', (ev) ->
  #   coordinates = ev.latlng
  #   Turbolinks.visit "/agile_pois/new?latitude=#{coordinates.lat}&longitude=#{coordinates.lng}"
  newTraciebleForm = $(".new-apoi-form")

  $('#add_apoi_marker').click (e) ->
    e.preventDefault()
    newTraciebleForm.addClass("open")
    ####addNewMarker = L.marker(map.getCenter()).addTo(map)
    #TODO: callbacks for latitude/longditude manipulation

  $('#cancel_add_apoi').click (e) ->
    e.preventDefault()
    clearNewApoiForm()
    newTraciebleForm.removeClass("open")
    # TODO: addNewMarker.remove

  $('#submit_agile_poi').click (e) ->
    e.preventDefault()
    newTraciebleForm.removeClass("open")
    # TODO: addNewMarker.remove
    saveAgilePOI $(".new-apoi-form .new_agile_poi").serializeObject(), ->
      clearNewApoiForm()
      #TODO: force redraw of apoi


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
