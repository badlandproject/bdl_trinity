let disabled = false;
let disabledFunction = null;

function Interval(time){
	var timer = false
	this.start = function(){
		if (this.isRunning()){
			clearInterval(timer)
			timer = false
		}

		timer = setInterval(function(){
			disabled = false
		},time)
	}

	this.stop = function(){
		clearInterval(timer)
		timer = false
	}

	this.isRunning = function(){
		return timer !== false
	}
}

const disableInventory = ms => {
	disabled = true

	if (disabledFunction === null){
		disabledFunction = new Interval(ms)
		disabledFunction.start()
	} else {
		if (disabledFunction.isRunning()){
			disabledFunction.stop()
		}
		disabledFunction.start()
	}
}

$(document).ready(function(){
	let actionContainer = $("#actionmenu");

	window.addEventListener("message",function(event){
		let item = event.data;
		switch(item.action){
			case "showMenu":
				$('.dropFromInv').hide();
				$('.meio').hide();
				$('.meioTake').hide();
				$('.dropFromChest').hide();
				updateMochila();
				actionContainer.fadeIn(500);
			break;

			case "hideMenu":
				actionContainer.fadeOut(500);
				$('.dragBlockStore').fadeOut(500);
				$('.dragBlockTake').fadeOut(500);
			break;

			case "updateMochila":
				$('.dropFromInv').fadeOut()
				$('.dropFromInv').hide(10);
				$('.dropFromChest').fadeOut()
				$('.dropFromChest').hide(10);
				$('#confirmar').off()
				updateMochila();
			break;
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://vrp_trunkchest/invClose");
		}
	};
});

const updateDrag = () => {
	$('#confirmar').off();
	$('#confirmarTake').off();
	$('.item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			if (disabled) return false;
			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key') };
			memo = $('.item').css('transition');
			$('.item').css('transition', 'none');
			$('.dropFromInv').fadeIn()
			$('.dropFromInv').show(10);
			if (itemData.key === undefined) return;
			
			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$('.dropFromInv').fadeOut()
			$('.dropFromInv').hide(10);
			$(this).children().children('img').show();
			$('.item').css('transition', memo);
			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.item2').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			if (disabled) return false;

			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key') };
			$('.dropFromChest').fadeIn();
			$('.dropFromChest').show(10);
			if (itemData.key === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$('.dropFromChest').fadeOut();
			$('.dropFromChest').hide(10);
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.esquerda').droppable({
		hoverClass: 'hoverControl',
		accept: '.item2',
		drop: function(event,ui){
			$('#confirmarTake').off();
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			disableInventory(500);

			$('.meioTake').fadeIn(500);
			$('.dragBlockTake').show();

			$('#confirmarTake').on('click',function(){
				$.post("http://vrp_trunkchest/takeItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amountTake").val())
			}))
			$('.meioTake').fadeOut(500);
			$('.dragBlockTake').fadeOut();
			document.getElementById("amountTake").value = "";
			console.log('bdl:inv_system - itemTook from sourceChest to user_source')
			})
		}
	})

	$('.direita').droppable({
		hoverClass: 'hoverControl',
		accept: '.item',
		drop: function(event,ui){
			$('#confirmar').off();
			itemData = { key: ui.draggable.data('item-key'), vehname: ui.draggable.data('vehname-key') };
			
			if (itemData.key === undefined || itemData.vehname === undefined) return;

			disableInventory(500);
			$('.meio').fadeIn(500);
			$('.dragBlockStore').show();
			$('#confirmar').click(() => {
				$.post("http://vrp_trunkchest/storeItem", JSON.stringify({
				item: itemData.key,
				vehname: itemData.vehname,
				amount: Number($("#amount").val())
			}))
			document.getElementById("amount").value = "";
			$('.meio').fadeOut(500);
			$('.dragBlockStore').fadeOut();
			console.log('bdl:inv_system - itemStored from user_source to sourceChest')
			})
		}
	})
}

function incrementValue()
{
    var value = parseInt(document.getElementById('amount').value, 10);
    value = isNaN(value) ? 0 : value;
    value++;
    document.getElementById('amount').value = value;
}

function subtractValue()
{
    var value = parseInt(document.getElementById('amount').value, 10);
    value = isNaN(value) ? 0 : value;
    value--;
    document.getElementById('amount').value = value;
}

function incrementValue2()
{
    var value = parseInt(document.getElementById('amountTake').value, 10);
    value = isNaN(value) ? 0 : value;
    value++;
    document.getElementById('amountTake').value = value;
}

function subtractValue2()
{
    var value = parseInt(document.getElementById('amountTake').value, 10);
    value = isNaN(value) ? 0 : value;
    value--;
    document.getElementById('amountTake').value = value;
}

$('#cancelar').on('click',function(){
	$('.dragBlockStore').fadeOut(500);
	$('.meio').fadeOut(500);
	
})

$('#cancelar2').on('click',function(){
	$('.dragBlockTake').fadeOut(500);
	$('.meioTake').fadeOut(500);
})

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

const updateMochila = () => {
	$.post("http://vrp_trunkchest/requestMochila",JSON.stringify({}),(data) => {
		const nameList = data.inventario.sort((a,b) => (a.name > b.name) ? 1: -1);
		const nameList2 = data.inventario2.sort((a,b) => (a.name > b.name) ? 1: -1);
		$('#inventory').html(`
			<div class="peso"><p><b>OCUPADO:</b> ${(data.peso).toFixed(2)}Kg    |  |    <b>TOTAL:</b>  ${(data.maxpeso).toFixed(2)}Kg </p></div>
			<div class="peso2"><p><b>OCUPADO:</b> ${(data.peso2).toFixed(2)}Kg    |  |    <b>TOTAL:</b>  ${(data.maxpeso2).toFixed(2)}Kg </p></div>
			<div class="esquerda">
				<div class="chestTitle">
					<p> Inventário </p>
				</div>
				<div class="esquerdaContent">
					${nameList2.map((item) => (`
						<div class="item" data-item-key="${item.key}" data-vehname-key="${item.vehname}">
							<div id="peso">${(item.peso*item.amount).toFixed(2)}</div>
							<div id="quantity">${formatarNumero(item.amount)}x</div>
							<div id="itemname">
								<div class="name">
									<p> ${item.name} </p>
								</div>
							</div>
							<img src="http://177.54.158.239/inventory/${item.index}.png">
						</div>
					`)).join('')}
				</div>
			</div>

			<div class="direita">
				<div class="chestTitle">
					<p> Veículo </p>
				</div>
				
				<div class="direitaContent">
					${nameList.map((item) => (`
						<div class="item2" data-item-key="${item.key}">
							<div id="peso">${(item.peso*item.amount).toFixed(2)}</div>
							<div id="quantity">${formatarNumero(item.amount)}x</div>
							<div id="itemname">
								<div class="name">
									<p> ${item.name} </p>
								</div>
							</div>
							<img src="http://177.54.158.239/inventory/${item.index}.png">
						</div>
					`)).join('')}
				</div>
			</div>
		`);
		updateDrag();
	});
}