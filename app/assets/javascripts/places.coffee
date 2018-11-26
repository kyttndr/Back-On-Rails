# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
  console.log 'test'
  window.initMap()

$(document).on 'turbolinks:load', ->
  window.initMap()

window.initMap = ->
  url_array = window.location.href.split('/')
  last_url = url_array.pop()
  if last_url == ''
    last_url = url_array.pop()
  reg = new RegExp('^\\d+$')
  console.log last_url

  if last_url == 'new'
    map = new (google.maps.Map)(document.getElementById('form_map'),
      center:
        lat: 43.66090860000001
        lng: -79.39595179999999
      zoom: 13)

    geocoder = new (google.maps.Geocoder)
    google.maps.event.addListener map, 'click', (event) ->
      geocoder.geocode { 'latLng': event.latLng }, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          if results[0]
            $('#place_address').val results[0].formatted_address
        return
      return

  else if reg.test last_url
    map = new (google.maps.Map)(document.getElementById('show_map'),
      center:
        lat: gon.place.latitude
        lng: gon.place.longitude
      zoom: 13)

    marker = new (google.maps.Marker)(
      position:
        lat: gon.place.latitude
        lng: gon.place.longitude
      title: gon.place.address
      map: map
      animation: google.maps.Animation.DROP
      url: '/places/' + gon.place.id)

  else if last_url == '0.0.0.0:3000' or last_url == 'back-on-rails.herokuapp.com'
    if gon.places.length == 0
      center_lat = 43.66090860000001
      center_lng = -79.39595179999999
    else
      center_lat = gon.places[0].latitude
      center_lng = gon.places[0].longitude

    map = new (google.maps.Map)(document.getElementById('index_map'),
      center:
        lat: center_lat
        lng: center_lng
      zoom: 13
      disableDefaultUI: true)

    i = 0
    while i < gon.places.length
      marker = new (google.maps.Marker)(
        position:
          lat: gon.places[i].latitude
          lng: gon.places[i].longitude
        title: gon.places[i].address
        map: map
        animation: google.maps.Animation.DROP
        url: '/places/' + gon.places[i].id)

      marker.addListener 'click', ->
        window.location.href = @url
        return
      i++

  else
    if gon.places.length == 0
      center_lat = 43.66090860000001
      center_lng = -79.39595179999999
    else
      center_lat = gon.places[0].latitude
      center_lng = gon.places[0].longitude

    map = new (google.maps.Map)(document.getElementById('map'),
      center:
        lat: center_lat
        lng: center_lng
      zoom: 13)

    i = 0
    while i < gon.places.length
      marker = new (google.maps.Marker)(
        position:
          lat: gon.places[i].latitude
          lng: gon.places[i].longitude
        title: gon.places[i].address
        map: map
        animation: google.maps.Animation.DROP
        url: '/places/' + gon.places[i].id)

      marker.addListener 'click', ->
        window.location.href = @url
        return
      i++

  return
