$(document).ready(function(){
	let actionContainer = $("#actionmenu");
	let actionButton = $("#actionbutton");

	window.addEventListener("message",function(event){
		let item = event.data;
		let $el = $('.model');
		let isActive = $el.hasClass('active');
		switch(item.action){
			case "showMenu":
				$('.confirmScreen').hide();
				actionButton.fadeIn(500);
				actionContainer.fadeIn(500);
				carregarMenu("inicio");
			break;

			case "hideMenu":
				actionButton.fadeOut(500);
				actionContainer.fadeOut(500);
				if (isActive == true) {
					$('.model').removeClass('active');
				} else {
					return
				}
			break;

			case 'updateCarros':
				updateCarros();
			break;

			case 'updateMotos':
				updateMotos();
			break;

			case 'updateImport':
				updateImport();
			break;

			case 'updatePossuidos':
				updatePossuidos();
			break;
		}
	});

	$("#inicio").load("./inicio.html");
	
	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://bdl_dealership/dealerClose",JSON.stringify({}),function(datab){});
		}
	};
});

$('#actionbutton').click(function(e){
	$.post("http://bdl_dealership/dealerClose",JSON.stringify({}),function(datab){});
});

const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}

const carregarMenu = (name) => {
	return new Promise((resolve) => {
		$("#inicio").load(name+".html",function(){
			resolve();
		});
	});
}

const updateCarros = () => {
	$('.comprar').css("opacity","1");
	$.post("http://bdl_dealership/requestCarros",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
				<div class="model" data-name-key="${item.k}">
					<div class="itemImage">
						<img src="http://177.54.158.239/dealership/${item.k}.png">
					</div>
					
					<div class="name"><p>${item.nome}</p></div>
					<div class="valor">$${formatarNumero(item.price)},00</div>
					<div class="malas">Peso: ${item.chest}Kg</div>
					<div class="estoque">Estoque: ${item.stock}</div>
					<div class="selectIcon"><i class="fas fa-circle"></i></div>
				</div>
			`)).join('')}
		`);
	});
}

const updateMotos = () => {
	$('.comprar').css("opacity","1");
	$.post("http://bdl_dealership/requestMotos",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="model" data-name-key="${item.k}">
				<div class="itemImage">
					<img src="http://177.54.158.239/dealership/${item.k}.png">
				</div>
			
				<div class="name"><p>${item.nome}</p></div>
				<div class="valor">$${formatarNumero(item.price)},00</div>
				<div class="malas">Peso: ${item.chest}Kg</div>
				<div class="estoque">Estoque: ${item.stock}</div>
				<div class="selectIcon"><i class="fas fa-circle"></i></div>
			</div>
			`)).join('')}
		`);
	});
}

const updateImport = () => {
	$('.comprar').css("opacity","1");
	$.post("http://bdl_dealership/requestImport",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="model" data-name-key="${item.k}">
				<div class="itemImage">
					<img src="http://177.54.158.239/dealership/${item.k}.png">
				</div>
			
				<div class="name"><p>${item.nome}</p></div>
				<div class="valor">$${formatarNumero(item.price)},00</div>
				<div class="malas">Peso: ${item.chest}Kg</div>
				<div class="estoque">Estoque: ${item.stock}</div>
				<div class="selectIcon"><i class="fas fa-circle"></i></div>
			</div>
			`)).join('')}
		`);
	});
}

const updatePossuidos = () => {
	$('.comprar').css("opacity","0");
	$.post("http://bdl_dealership/requestPossuidos",JSON.stringify({}),(data) => {
		let i = 0;
		const nameList = data.veiculos.sort((a,b) => (a.nome > b.nome) ? 1: -1);
		$('#inicio').html(`
			${nameList.map((item) => (`
			<div class="model" data-name-key="${item.k}">
				<div class="itemImage">
					<img src="http://177.54.158.239/dealership/${item.k}.png">
				</div>
			
				<div class="name"><p>${item.nome}</p></div>
				<div class="valor">$${formatarNumero(item.price)},00</div>
				<div class="malas">Peso: ${item.chest}Kg</div>
				<div class="selectIcon"><i class="fas fa-circle"></i></div>
			</div>
			`)).join('')}
		`);
	});
}

$(document).on("click",".model",function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.model').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$('.comprar').click(function(){
	let $el = $('.model');
	let isActive = $el.hasClass('active');
	if (isActive == true) {
		$('.confirmScreen').fadeIn(250);
	} else {
		return
	}
});

$('.voltarCompra').click(function(){
	$('.confirmScreen').fadeOut(250);
});

$(document).on("click",".confirmarCompra",function(){
	let $el = $('.model.active');
	if($el){
		$.post("http://bdl_dealership/buyDealer",JSON.stringify({
			name: $el.attr('data-name-key')
		}));
		$('.confirmScreen').fadeOut(250);
	}
});