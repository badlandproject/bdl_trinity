$(function() {
	init();
  
	var actionContainer = $("body");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;

	  if (item.showmenu) {
		ResetMenu();
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)')
		actionContainer.fadeIn();
	  }
  
	  if (item.hidemenu) {
		$('body').css('background-color', 'transparent')
		actionContainer.fadeOut();
	  }

	  if (item.gender == "male") {
		$('.default').attr('src','http://177.54.158.239/pdcloak/defaultM.png');
		$('.default2').attr('src','http://177.54.158.239/pdcloak/default2M.png');
		$('.gtm').attr('src','http://177.54.158.239/pdcloak/gtmM.png');
		$('.tactical').attr('src','http://177.54.158.239/pdcloak/tacticalM.png');
		$('.canine').attr('src','http://177.54.158.239/pdcloak/canineM.png');
		$('.transit').attr('src','http://177.54.158.239/pdcloak/transitM.png');
		$('.csi').attr('src','http://177.54.158.239/pdcloak/csiM.png');
		$('.student').attr('src','http://177.54.158.239/pdcloak/studentM.png');
	} else if (item.gender == "female") {
		$('.default').attr('src','http://177.54.158.239/pdcloak/defaultF.png');
		$('.default2').attr('src','http://177.54.158.239/pdcloak/default2F.png');
		$('.gtm').attr('src','http://177.54.158.239/pdcloak/gtmF.png');
		$('.tactical').attr('src','http://177.54.158.239/pdcloak/tacticalF.png');
		$('.canine').attr('src','http://177.54.158.239/pdcloak/canineF.png');
		$('.transit').attr('src','http://177.54.158.239/pdcloak/transitF.png');
		$('.csi').attr('src','http://177.54.158.239/pdcloak/csiF.png');
		$('.student').attr('src','http://177.54.158.239/pdcloak/studentF.png');
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
	$.post("http://bdl_pdcloak/" + name, JSON.stringify(data), function(
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