$(function() {
	init();
  
	var actionContainer = $("body");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		ResetMenu();
		$('body').css('background-color', 'rgba(0, 0, 0, 0.15)');
		$('.general').show();
		$('.brancas').hide();
		$('.weapons').hide();
		$('.ammunition').hide();


		$('.containerFIVE').hide();
		$('.containerGLOCK').hide();
		$('.containerM19').hide();
		$('.containerM22').hide();
		$('.containerHK110').hide();

		// MUNICOES //

		$('.containerMuniFive').hide();
		$('.containerMuniGlock').hide();
		$('.containerMuniM1911').hide();
		$('.containerMuniM22').hide();
		$('.containerMuniHK110').hide();

		// ARMAS BRANCAS //

		$('.containerKnife').hide();
		$('.containerMachado').hide();
		$('.containerCanivete').hide();
		$('.containerBaseball').hide();
		$('.containerMartelo').hide();
		$('.containerGolf').hide();
		$('.containerCabra').hide();
		$('.containerSoco').hide();
		$('.containerChaveIng').hide();
		$('.containerSinuca').hide();

		actionContainer.fadeIn();
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

  $('.confirm57').click(function(){
	$('.containerFIVE').fadeIn();
	$('.containerFIVE').show(50);
  })

  $('.confirmGlock').click(function(){
	$('.containerGLOCK').fadeIn();
	$('.containerGLOCK').show(50);
  })

  $('.confirmM1911').click(function(){
	$('.containerM19').fadeIn();
	$('.containerM19').show(50);
  })

  $('.confirmM22').click(function(){
	$('.containerM22').fadeIn();
	$('.containerM22').show(50);
  })

  $('.confirmHK110').click(function(){
	$('.containerHK110').fadeIn();
	$('.containerHK110').show(50);
  })

  //  --  Munições --  //

  $('.confirmMuniFive').click(function(){
	$('.containerMuniFive').fadeIn();
	$('.containerMuniFive').show(50);
  })

  $('.confirmMuniGlock').click(function(){
	$('.containerMuniGlock').fadeIn();
	$('.containerMuniGlock').show(50);
  })

  $('.confirmMuniM1911').click(function(){
	$('.containerMuniM1911').fadeIn();
	$('.containerMuniM1911').show(50);
  })

  $('.confirmMuniM22').click(function(){
	$('.containerMuniM22').fadeIn();
	$('.containerMuniM22').show(50);
  })

  $('.confirmMuniHK110').click(function(){
	$('.containerMuniHK110').fadeIn();
	$('.containerMuniHK110').show(50);
  })

  // ARMAS BRANCAS //

  $('.confirmKnife').click(function(){
	$('.containerKnife').fadeIn();
	$('.containerKnife').show(50);
  })

  $('.confirmMachado').click(function(){
	$('.containerMachado').fadeIn();
	$('.containerMachado').show(50);
  })

  $('.confirmCanivete').click(function(){
	$('.containerCanivete').fadeIn();
	$('.containerCanivete').show(50);
  })

  $('.confirmBaseball').click(function(){
	$('.containerBaseball').fadeIn();
	$('.containerBaseball').show(50);
  })

  $('.confirmMartelo').click(function(){
	$('.containerMartelo').fadeIn();
	$('.containerMartelo').show(50);
  })


  $('.confirmGolf').click(function(){
	$('.containerGolf').fadeIn();
	$('.containerGolf').show(50);
  })

  $('.confirmCabra').click(function(){
	$('.containerCabra').fadeIn();
	$('.containerCabra').show(50);
  })

  $('.confirmSoco').click(function(){
	$('.containerSoco').fadeIn();
	$('.containerSoco').show(50);
  })

  $('.confirmWrench').click(function(){
	$('.containerChaveIng').fadeIn();
	$('.containerChaveIng').show(50);
  })

  $('.confirmSinuca').click(function(){
	$('.containerSinuca').fadeIn();
	$('.containerSinuca').show(50);
  })

  $('.knives').click(function(){
	$('.brancas').show();
	$('.ammunition').hide();
	$('.weapons').hide();
	$('.general').hide();
  })

  $('.guns').click(function(){
	$('.weapons').show();
	$('.brancas').hide();
	$('.ammunition').hide();
	$('.general').hide();
  })

  $('.ammo').click(function(){
	$('.ammunition').show();
	$('.weapons').hide();
	$('.brancas').hide();
	$('.general').hide();
  })


  
  $('.buyButton').click(function(){
	$('.containerFIVE').fadeOut();
	$('.containerGLOCK').fadeOut();
	$('containerM19').fadeOut();
	$('.containerM22').fadeOut();
	$('.containerHK110').fadeOut();
	$('.containerFIVE').hide(50);
	$('.containerGLOCK').hide(50);
	$('.containerM19').hide(50);
	$('.containerM22').hide(50);
	$('.containerHK110').hide(50);

	// MUNICOES //

	$('.containerMuniFive').fadeOut();
	$('.containerMuniFive').hide(50);
	$('.containerMuniGlock').fadeOut();
	$('.containerMuniGlock').hide(50);
	$('.containerMuniM1911').fadeOut();
	$('.containerMuniM1911').hide(50);
	$('.containerMuniM22').fadeOut();
	$('.containerMuniM22').hide(50);
	$('.containerMuniHK110').fadeOut();
	$('.containerMuniHK110').hide(50);

	// ARMAS BRANCAS //

	$('.containerKnife').fadeOut();
	$('.containerMachado').fadeOut();
	$('.containerCanivete').fadeOut();
	$('.containerBaseball').fadeOut();
	$('.containerMartelo').fadeOut();
	$('.containerGolf').fadeOut();
	$('.containerCabra').fadeOut();
	$('.containerSoco').fadeOut();
	$('.containerChaveIng').fadeOut();
	$('.containerSinuca').fadeOut();
	$('.containerKnife').hide(50);
	$('.containerMachado').hide(50);
	$('.containerCanivete').hide(50);
	$('.containerBaseball').hide(50);
	$('.containerMartelo').hide(50);
	$('.containerGolf').hide(50);
	$('.containerCabra').hide(50);
	$('.containerSoco').hide(50);
	$('.containerChaveIng').hide(50);
	$('.containerSinuca').hide(50);
  })

  $('.closeAmount').click(function(){
	$('.containerFIVE').fadeOut();
	$('.containerGLOCK').fadeOut();
	$('containerM19').fadeOut();
	$('.containerM22').fadeOut();
	$('.containerHK110').fadeOut();
	$('.containerFIVE').hide(25);
	$('.containerGLOCK').hide(25);
	$('.containerM19').hide(25);
	$('.containerM22').hide(25);
	$('.containerHK110').hide(25);

	// MUNICOES //

	$('.containerMuniFive').fadeOut();
	$('.containerMuniFive').hide(50);
	$('.containerMuniGlock').fadeOut();
	$('.containerMuniGlock').hide(50);
	$('.containerMuniM1911').fadeOut();
	$('.containerMuniM1911').hide(50);
	$('.containerMuniM22').fadeOut();
	$('.containerMuniM22').hide(50);
	$('.containerMuniHK110').fadeOut();
	$('.containerMuniHK110').hide(50);

	// ARMAS BRANCAS //

	$('.containerKnife').fadeOut();
	$('.containerMachado').fadeOut();
	$('.containerCanivete').fadeOut();
	$('.containerBaseball').fadeOut();
	$('.containerMartelo').fadeOut();
	$('.containerGolf').fadeOut();
	$('.containerCabra').fadeOut();
	$('.containerSoco').fadeOut();
	$('.containerChaveIng').fadeOut();
	$('.containerSinuca').fadeOut();
	$('.containerKnife').hide(50);
	$('.containerMachado').hide(50);
	$('.containerCanivete').hide(50);
	$('.containerBaseball').hide(50);
	$('.containerMartelo').hide(50);
	$('.containerGolf').hide(50);
	$('.containerCabra').hide(50);
	$('.containerSoco').hide(50);
	$('.containerChaveIng').hide(50);
	$('.containerSinuca').hide(50);

  })

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
	$.post("http://bdl_gunshop/" + name, JSON.stringify(data), function(
	  datab
	) {
	  if (datab != "ok") {
		console.log(datab);
	  }
	});
  
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
  })

}