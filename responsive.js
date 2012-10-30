//CONFIG
//Base URL
var url = "http://nurelm.com";
//UserAgent String for Testing
var IPHONE ="Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5";

$(document).ready(function(){
	(function($){
	    $.fn.disableSelection = function() {
        	return this
                 .attr('unselectable', 'on')
                 .css('user-select', 'none')
                 .on('selectstart', false);
    	};
	})(jQuery);
	(function($){
	    $.fn.enableSelection = function() {
	        return this
	                 .attr('unselectable', 'off')
	                 .css('user-select', 'text')
	                 .on('selectstart', null);
	    };
	})(jQuery);
});

//Little regex to grab parameters of the request url for testing
function getParameterByName(name){
  name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
  var regexS = "[\\?&]" + name + "=([^&#]*)";
  var regex = new RegExp(regexS);
  var results = regex.exec(window.location.search);
  if(results == null)
    return "";
  else
    return decodeURIComponent(results[1].replace(/\+/g, " "));
}

// The Meat which loads the frame up
function loadPage(url) {
  if ( url.substr(0,7) !== 'http://' && url.substr(0,8) !== 'https://' && url.substr(0, 7) !== 'file://' ) {
    url = 'http://'+url;
  }
  $('iframe').attr('src', url);
}
function forceReload(){
	return $("#forcereload").attr('checked') == 'checked';
}

function animateSize(size){ //handles the animation and display of the current width
	$('#frame1').animate({
	    height: size.height,
		width: size.width
	  }, {duration: 1000,
		step: function( moment, fx ){
			if(fx.prop === "width"){
				$('#customSizeValue').text(moment.toFixed(0));
			}
		}}, function() {
		$('#customSizeValue').text($(this).width());
	  });
	if(forceReload()){  //Forces the page to reload its contents on click if the checkbox is selected
	 loadPage(url);
	}
}
	$(document).ready(function(){
		
		
		//Little Buddy that allows you to add any custom size from the input field
		$("#customSize").keyup(function(){
			var val = parseInt($(this).val());
			if(val.toString() !== "NaN"){
			  $("#frame1").stop();
			  animateSize({
				"height": "1000px",
				"width": val+ "px"
			  });
			}
		});
		
		//Control Handle to adjust width
		$("#widthHandle").unbind("mousedown").mousedown(function(e){
			var doclimit = document.width - $("#widthHandle").width();
			$(document).disableSelection(); //Keeps you from accidentally selecting while dragging
			$(document).unbind("mousemove").mousemove(function(e2){
				var right = $("#widthHandle").offset().left + $("#widthHandle").width();
				if(e2.pageX < doclimit){
					$("#widthHandle").offset({left: e2.pageX - $("#widthHandle").width()});
					$('#frame1').stop();
					$('#frame1').width($("#widthHandle").offset().left+"px");
					$('#customSizeValue').text($('#frame1').width().toFixed(0));
				}else{
					$("#widthHandle").offset({left: $("#widthHandle").offset().left});
					//$("#widthHandle").offset({left: right - ($("#widthHandle").width()+1)});
					//$('#frame1').width($("#widthHandle").offset().left+"px");
				}
			}).one();
			$(document).unbind("mouseup").mouseup(function(e3) {
				$(document).enableSelection(); //Select away
				$(document).unbind("mousemove");  // unbind events from widthHandle
				$(this).unbind("mouseup");
			}).one();
		});
		
		//Better Buddy that lets you add any anchor under the #sizeButtons div and it will set the width to the value of the id of that anchor
		$("#sizeButtons a").each(function(){
			$(this).click(function(){
				var height = "1000px";
				var width = $(this).attr("id")+'px';

				var size = {"height": height,
							"width": width};
				$("#frame1").stop();
				animateSize(size);
				$("#customSize").val(size.width);
			})
		});
		
		//Slow Buddy allows you to add any anchor to the #links div and it will use the value of the href attribute to provide a new location for the iframe
		$("#links a").each(function(){
			$(this).click(function(){
				loadPage($(this).attr("href"));
				return false;
			});
		});
		
		//Hack attempt to override the document.domain ignore for now
		//it works just doesn't do anything useful
		document.__defineGetter__('domain', function(){
			return url.replace("http://", "");
		});
		//Hack attempt to override the document.domain ignore for now
		
		//future feature for passing a mode to the iframe
		var mode = getParameterByName("mode");
		if(mode != ""){
			if(mode == "iphone"){
				navigator.__defineGetter__('userAgent', function(){
						return( "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_3_2 like Mac OS X; en-us) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8H7 Safari/6533.18.5" );
					});
			}
		}
		
		$('form').submit(function(){
		    loadPage($('#url input[type=text]').val());
			url = $('#url input[type=text]').val();
		    return false;
		});
		
		//default initial page action. Required becasue apparently the iframe inherits the first load as its parent object
		//only that object can make changes in this case it should be the local window object
		//basically leave this alone
		loadPage(url);
	});