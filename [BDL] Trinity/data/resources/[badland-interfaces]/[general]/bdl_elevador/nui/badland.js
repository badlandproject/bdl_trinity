$(function() {
	init();
  
	var actionContainer = $(".actionmenu");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		ResetMenu();
		$('#lspdbuttons').hide();
		$('#emsbuttons').hide();
		$('body').css('background-color', 'rgba(0, 0, 75, 0.15)')
		actionContainer.fadeIn();
		
	  }
	  
	  if (item.elevEMS) {
		$('#lspdbuttons').hide();
		$('#emsbuttons').show();
		$('.mainContainer').css("height","25vw");
		$('.middleLineOne').css("top","20.5vw");
		$('.middleLineTwo').css("top","22vw");
		$('.middleLineThree').css("top","20.5vw");
		$('.middleLineFour').css("top","22vw");
		$('.buttonStyleMiddle').css("top","19vw");
		$('.titleContainer h1').text("EMS - ELEVADOR");
	  } 
	  if (item.elevLSPD) {
		$('#lspdbuttons').show();
		$('#emsbuttons').hide();
		$('.mainContainer').css("height","35vw");
		$('.middleLineOne').css("top","30.5vw");
		$('.middleLineTwo').css("top","32vw");
		$('.middleLineThree').css("top","30.5vw");
		$('.middleLineFour').css("top","32vw");
		$('.buttonStyleMiddle').css("top","29vw");
		$('.titleContainer h1').text("LSPD - ELEVADOR");
	  }
	  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }
	  
	});
	
  
	document.onkeyup = function(data) {
	  if (data.which == 27) {
		if (actionContainer.is(":visible")) {
		  sendData("ButtonClick", "fechar");
		}
	  }
	};
  });
  
  function ResetMenu() {
	$("div").each(function(i, obj) {
	  var element = $(this);
  
	  if (element.attr("data-parent")) {
		element.hide();
	  } else {
		element.show();
	  }
	});
  }
  
  function init() {
	$(".menuoption").each(function(i, obj) {
	  if ($(this).attr("data-action")) {
		$(this).click(function() {
		  var data = $(this).data("action");
		  sendData("ButtonClick", data);
		});
	  }
  
	  if ($(this).attr("data-sub")) {
		var menu = $(this).data("sub");
		var element = $("#" + menu);
  
		$(this).click(function() {
		  element.show();
		  $("#mainmenu").hide();
		});
  
		$(".subtop button, .back").click(function() {
		  element.hide();
		  $("#mainmenu").show();
		});
	  }
	});
  }
  
  function sendData(name, data) {
	$.post("http://bdl_elevador/" + name, JSON.stringify(data), function(
	  datab
	) {
	  if (datab != "ok") {
		console.log(datab);
	  }
	});
  }
  
  $('.category_item').click(function() {
	let pegArma = $(this).attr('category');
	$('.item-item').css('transform', 'scale(0)');
  
	function hideArma() {
		$('.item-item').hide();
	}
	setTimeout(hideArma, 100);
  
	function showArma() {
		$('.item-item[category="' + pegArma + '"]').show();
		$('.item-item[category="' + pegArma + '"]').css('transform', 'scale(1)');
	}
	setTimeout(showArma, 100);
  });
  
  $('.category_item[category="all"]').click(function() {
	function showAll() {
		$('.item-item').show();
		$('.item-item').css('transform', 'scale(1)');
	}
	setTimeout(showAll, 100);
  });