$(document).ready(function() {

	/**
	* Scroll animation if click navbar menu
	**/
	$('a.navbar-brand, ul.navbar-nav > li > a').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });

	/**
	* Navbar collapse close if clicking menu on mobile
	**/
    if($(window).width() < 767){
    	$('ul.navbar-nav > li > a').on('click', function(){
    		$('.navbar-collapse').removeClass('in');
    		$('.navbar-collapse').attr('style', 'height: 1');
    	});
    }

	/**
	* Call tooltip & carousel bootstrap js
	**/
    $('[rel="tooltip"]').tooltip();
    $('#wedding-photo').carousel();

	/**
	* Call colorbox on wedding photo gallery
	**/
    if($(window).width() > 767){
		$(".gallery-images").colorbox({rel:'gallery-images', width:'auto', height: '85%'});
	}else{
		$(".gallery-images").colorbox({rel:'gallery-images', width:'85%', height: 'auto'});
	}

	/**
	* Display map in contact section using gmap 3
	**/
  var receptionLoc = [44.9858315,-93.276208];
  var ceremonyLoc = [44.973076,-93.286344];
  var marriottLoc = [44.987176,-93.274318];
  var hyattLoc = [44.971198,-93.27774];
	$("#maps").gmap3({
    map:{
		  options:{
		    center: ceremonyLoc,
		    zoom: 14,
			  scrollwheel: false,
		  }
 		},
 		marker:{
      values : [
        {latLng: receptionLoc, data: "Reception: 514 Studios"},
        {latLng: ceremonyLoc, data: "Ceremony: Basilica of Saint Mary"},
        {latLng: marriottLoc, data: "Hotel 1: TownePlace Suites by Marriott"},
        {latLng: hyattLoc, data: "Hotel 2: Hyatt Regency Hotel"},
      ],
      options:{
        draggable: false
      },
      events:{
        mouseover: function(marker, event, context){
          var map = $(this).gmap3("get"),
            infowindow = $(this).gmap3({get:{name:"infowindow"}});
          if (infowindow){
            infowindow.open(map, marker);
            infowindow.setContent(context.data);
          } else {
            $(this).gmap3({
              infowindow:{
                anchor:marker,
                options:{content: context.data}
              }
            });
          }
        },
        mouseout: function(){
          var infowindow = $(this).gmap3({get:{name:"infowindow"}});
          if (infowindow){
            infowindow.close();
          }
        }
  		}
    }

  });

});

