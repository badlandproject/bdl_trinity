$(document).ready(function(){
	let actionContainer = $("#actionmenu");

	window.addEventListener('message',function(event){
		let item = event.data;
		switch(item.action){
			case 'showMenu':
				updateGarages();
				actionContainer.fadeIn(200);
			break;

			case 'hideMenu':
				actionContainer.fadeOut(200);
				
			break;

			case 'updateGarages':
				updateGarages();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			sendData("ButtonClick","exit")
		}
	};
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

const sendData = (name,data) => {
	$.post("http://bdl_garages/"+name,JSON.stringify(data),function(datab){});
}


const updateGarages = () => {
    $.post('http://bdl_garages/myVehicles',JSON.stringify({}),(data) => {
		const nameList = data.vehicles.sort((a,b) => (a.name2 > b.name2) ? 1: -1);
		$('#garagem').html(`
			${nameList.map((item) => (`
					<div onclick="selectItem(this)" class="item" data-item-name="${item.name}">
					<div class="item-imageName">
						<img src="http://177.54.158.239/garages/${item.name}.png">
					</div>
					<div class="item-textName">
						<div class="item-name"><p>${item.name2}</p></div>
					</div>
					<div class="item-textStatus">
						<div class="item-left">Motor: ${item.engine}% / Carroceria: ${item.body}% / Gasolina: ${item.fuel}% </b></div><div class="item-right"></div>
					</div>
					<div class="carIcon">
						${item.vehstate}
					</div>
					<div class="item-text">
						<div class="item-status">Liberação: ${item.status}</div>		
					</div>
					<div class="item-text" style="border: 0;">
                        <div class="item-taxa">Taxa: ${item.ipva}</div>
                    </div>
				</div>
			`)).join('')}
		`);
		
	});
}

function selectItem(element) {
    if (element.dataset.state == 1) {
        $('.tarifa').removeClass("desactive");
        $('.tarifa').removeAttr("disabled");
        $('.return').removeClass("desactive");
        $('.return').removeAttr("disabled");
        $(element).css('border-right', '1px solid #409eff')
    }
    if (element.dataset.state == 0) {
        $('.tarifa').addClass("desactive");
        $('.tarifa').attr("disabled");
        $('.return').addClass("desactive");
        $('.return').attr("disabled");
        $(element).css('border-right', '1px solid #1db3189d')
    }
}

$(document).on('click','.item',function(){
	let $el = $(this);
	let isActive = $el.hasClass('active');
	$('.item').removeClass('active');
	if(!isActive) $el.addClass('active');
});

$(document).on('click','.retirar',function(){
	let $el = $('.item.active');
	if($el) {
		$.post('http://bdl_garages/spawnVehicles',JSON.stringify({
			name: $el.attr('data-item-name')
		}));
	}
})

$(document).on('click','.guardar',function(){
	$.post('http://bdl_garages/deleteVehicles',JSON.stringify({}));
	
})