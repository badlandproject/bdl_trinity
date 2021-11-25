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
		$('.enfermeiro').attr('src','http://177.54.158.239/emcloak/enfermeiroM.png');
		$('.paramedico').attr('src','http://177.54.158.239/emcloak/paramedicoM.png');
		$('.medico').attr('src','http://177.54.158.239/emcloak/medicoM.png');
		$('.clinico').attr('src','http://177.54.158.239/emcloak/clinicoM.png');
		$('.diretor').attr('src','http://177.54.158.239/emcloak/diretorM.png');
		$('.resgate').attr('src','http://177.54.158.239/emcloak/resgateM.png');
	} else if (item.gender == "female") {
		$('.enfermeiro').attr('src','http://177.54.158.239/emcloak/enfermeiroF.png');
		$('.paramedico').attr('src','http://177.54.158.239/emcloak/paramedicoF.png');
		$('.medico').attr('src','http://177.54.158.239/emcloak/medicoF.png');
		$('.clinico').attr('src','http://177.54.158.239/emcloak/clinicoF.png');
		$('.diretor').attr('src','http://177.54.158.239/emcloak/diretorF.png');
		$('.resgate').attr('src','http://177.54.158.239/emcloak/resgateF.png');
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
	$.post("http://bdl_emcloak/" + name, JSON.stringify(data), function(
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