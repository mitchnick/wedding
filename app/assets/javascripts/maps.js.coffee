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


  # var receptionLoc = [44.9858315,-93.276208];
  # var ceremonyLoc = [44.973076,-93.286344];
  # var marriottLoc = [44.987176,-93.274318];
  # var hyattLoc = [44.971198,-93.27774];
  # $("#maps").gmap3({
  #   map:{
  #     options:{
  #       center: ceremonyLoc,
  #       zoom: 14,
  #       scrollwheel: false,
  #     }
  #   },
  #   marker:{
  #     values : [
  #       {latLng: receptionLoc, data: "Reception: 514 Studios"},
  #       {latLng: ceremonyLoc, data: "Ceremony: Basilica of Saint Mary"},
  #       {latLng: marriottLoc, data: "Hotel 1: TownePlace Suites by Marriott"},
  #       {latLng: hyattLoc, data: "Hotel 2: Hyatt Regency Hotel"},
  #     ],
  #     options:{
  #       draggable: false
  #     },
  #     events:{
  #       mouseover: function(marker, event, context){
  #         var map = $(this).gmap3("get"),
  #           infowindow = $(this).gmap3({get:{name:"infowindow"}});
  #         if (infowindow){
  #           infowindow.open(map, marker);
  #           infowindow.setContent(context.data);
  #         } else {
  #           $(this).gmap3({
  #             infowindow:{
  #               anchor:marker,
  #               options:{content: context.data}
  #             }
  #           });
  #         }
  #       },
  #       mouseout: function(){
  #         var infowindow = $(this).gmap3({get:{name:"infowindow"}});
  #         if (infowindow){
  #           infowindow.close();
  #         }
  #       }
  #     }
  #   }

  # });
