Maps =
  init: ->
    receptionLoc = [44.9858315,-93.276208]
    ceremonyLoc = [44.973076,-93.286344]
    marriottLoc = [44.987176,-93.274318]
    hyattLoc = [44.971198,-93.27774]

    markersData = [
      {
        'lat': 44.9858315
        'lng': -93.276208
        'infowindow': 'Reception: 514 Studios'
      }, {
        'lat': 44.973076
        'lng': -93.286344
        'infowindow': 'Ceremony: Basilica of Saint Mary'
      }, {
        'lat': 44.987176
        'lng': -93.274318
        'infowindow': 'Hotel 1: TownePlace Suites by Marriott'
      }, {
        'lat': 44.971198
        'lng': -93.27774
        'infowindow': 'Hotel 2: Hyatt Regency Hotel'
      }
    ]

    handler = Gmaps.build('Google', { markers: { draggable: false } })
    handler.buildMap {
      provider: {}
      internal: id: 'maps'
    }, ->
      markers = handler.addMarkers(markersData)
      handler.bounds.extendWith markers
      handler.fitMapToBounds()
      return

  pageLoad: ->
    @setAlertTimeout();

  setAlertTimeout: ->
    window.setTimeout (->
      $('.alert-message-disappear').fadeTo(500, 0).slideUp 500, ->
        $(this).remove()
        return
      return
    ), 3000

$ ->
  Maps.init()
