$(function() {
	init();
  
	var actionContainer = $("body");
  
	window.addEventListener("message", function(event) {
	  var item = event.data;
  
	  if (item.showmenu) {
		ResetMenu();
		$('.helpContainer').hide();
		
		$('.queryContainer').hide();
		$('#hireUI').hide();
		$('#fireUI').hide();
		$('#promoteUI').hide();
		$('body').css('background-color', 'rgba(0, 0, 50, 0.3)');
		actionContainer.fadeIn();
	  }

	  if(item.infoShowUser) {
		let name = item.nome
		let job = item.job
		let registration = item.registration
		let age = item.age
		$('.resultUser #resultName').html(name)
		$('.resultUser #resultJob').html(job)
		$('.resultUser #resultReg').html(registration)
		$('.resultUser #resultAge').text(age+" Anos")
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
		  $("#inputId").val('');
		}
	  }
	  
	};
  });

  

  $('body').on('submit', '#resultUser', function(e) {
	e.preventDefault();
	$('.resultUser').show();
	let valor = $('#resultUser #inputId').val();
	$.post('http://bdl_pdhire/pegarUser', JSON.stringify({ id: valor }));
});

  $('.hireOption').click(function(){
	$('.mainContainerWithout').hide();
	$('.IDContainer').fadeIn();
	$('#promoteUI').hide();
	$('#fireUI').hide();
	$('#hireUI').show();
})

$('#helpButton').click(function(){
	$('.mainContainer').hide();
	$('.helpContainer').fadeIn();
	$('.helpContainer').show(100);
})

$('.fireOption').click(function(){
	$('.mainContainerWithout').hide();
	$('.IDContainer').fadeIn();
	$('#promoteUI').hide();
	$('#hireUI').hide();
	$('#fireUI').show();
})

$('.promoteOption').click(function(){
	$('.mainContainerWithout').hide();
	
	$('.IDContainer').fadeIn();
	$('#hireUI').hide();
	$('#fireUI').hide();
	$('#promoteUI').show();
})

$('#backButtonHire').click(function(){
	$('.mainContainerWithout').fadeIn();
	$('.mainContainerWithout').show(100);
	
	$('.helpContainer').hide();
	$('#hireUI').hide();
	$('.mainContainerWithout').show();
	$('.IDContainer').fadeOut();
})

$('#backButtonFire').click(function(){
	$('.mainContainerWithout').fadeIn();
	$('.mainContainerWithout').show(100);
	
	$('.helpContainer').hide();
	$('#fireUI').hide();
	$('.mainContainer').show();
	$('.IDContainer').fadeOut();
})

$('#backButtonPromote').click(function(){
	$('.mainContainerWithout').fadeIn();
	$('.mainContainerWithout').show(100);
	
	$('.helpContainer').hide();
	$('#promoteUI').hide();
	$('.mainContainer').show();
	$('.IDContainer').fadeOut();
})

$('#closeButton').click(function(){
	$("#inputId").val('');
})

$('#backButtonHelp').click(function(){
	$('.mainContainer').fadeIn();
	$('.mainContainer').show(100);
	$('.helpContainer').hide();
	
	$('.helpContainer').fadeOut();
})

$('#backButtonQuery').click(function(){
	$('.mainContainer').fadeIn();
	$('.mainContainer').show(100);
	$('.queryContainer').hide();
	$('.queryContainer').fadeOut();
})


$("#contratar1").submit(function(e) {
	e.preventDefault();
	$.post('http://bdl_pdhire/contratar', JSON.stringify({
		position: $("#position").val(),
		passport: $("#passport").val()
	}));
	$('.mainContainerWithout').fadeIn();
	$('.mainContainerWithout').show(100);
	
	$('.IDContainer').fadeOut();
	$('.IDContainer').hide();
	$("#passport").val('');
	$("#position").val('');
});

$("#demitir1").submit(function(e) {
	e.preventDefault();
	$.post('http://bdl_pdhire/demitir', JSON.stringify({
		passport: $("#passport-fire").val()
	}));
	$('.mainContainerWithout').fadeIn();
	$('.mainContainerWithout').show(100);
	$('.mainContainer').css('background-color', 'rgba(0, 0, 0, 0.15)');
	$('.IDContainer').hide();
	$("#passport-fire").val('');
	$("#position-fire").val('');
});

$("#promover1").submit(function(e) {
	e.preventDefault();
	$.post('http://bdl_pdhire/promover', JSON.stringify({
		position: $("#position-promote").val(),
		passport: $("#passport-promote").val()
	}));
	$('.IDContainer').hide();
	$('.mainContainerWithout').fadeIn();
	$('.mainContainerWithout').show(100);
	$('.mainContainer').css('background-color', 'rgba(0, 0, 0, 0.15)');
	$("#passport-promote").val('');
	$("#position-promote").val('');
});

window.addEventListener('message', (event) => {
	let data = event.data
	if(data.type == 'open') {
		const nome = data.nome + ' ' + data.sobrenome;
		const emprego = data.emprego;
		const id = data.id;
		const idade = data.idade;

		$('.emprego span').text(emprego);
		$('.nome span').text(nome);
		$('.identidade span').text(id);
		$('.idade span').text(idade);
	}
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
	$.post("http://bdl_pdhire/" + name, JSON.stringify(data), function(
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

