# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(window).load ->
  window.initMap()

$(document).on 'turbolinks:load', ->
  window.initMap()

jQuery ->
  window.initMap = ->
    map = new (google.maps.Map)(document.getElementById('map'),
      center:
        lat: 43.66090860000001
        lng: -79.39595179999999
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
