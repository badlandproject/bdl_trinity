// --------------------------------------------------------------------------------------------------------
// -- [ PRODUTO ADQUIRIDO EM E&G VENDAS (discord.gg/bABGBEX) ]   										 --
// -- [ DESENVOLVIDO POR Edu#0069 // BACK-END POR ALLSTAR BASE ]   									  	 --
// -- [ SE VOCÊ ADQUIRIU ESSE PRODUTO, VOCÊ TEM DIREITO A SUPORTE GRATUITO ]   						  	 --
// -- [ OBRIGADO PELA CONFIANÇA // CONTATO: Edu#0069 // GITHUB: https://github.com/badlandproject  ]     --
// --------------------------------------------------------------------------------------------------------

$(document).ready(function(){
	var actionContainer = $("#actionmenu");
	window.addEventListener("message",function(event){
		switch(event.data.action){
			case "showMenu":
				updateMochila();
				actionContainer.fadeIn(400);
			break;

			case "hideMenu":
				actionContainer.fadeOut(400);
				$('.amountBackground').fadeOut(250);
			break;

			case "updateMochila":
				updateMochila();
			break;

			
		}

		if (event.data.tag == "staffDoador") {
			$('.staff').show();
			$('.doador').show();
			$('.usuario').hide();
		} else if (event.data.tag == "userDoador") {
			$('.doador').show();
			$('.usuario').show();
			$('.staff').hide();
		} else if (event.data.tag == "onlyStaff") {
			$('.staff').show();
			$('.usuario').hide();
			$('.doador').hide();
		} else if (event.data.tag == "onlyUser") {
			$('.usuario').show();
			$('.staff').hide();
			$('.doador').hide();
		}
	});

	document.onkeyup = function(data){
		if (data.which == 27){
			$.post("http://bdl_inventory/invClose");
		}
	};
});


const updateDrag = () => {
	$('#confirmar').off();
	$('.item').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key'), type: $(this).data('item-type') };
			if (itemData.key === undefined || itemData.type === undefined) return;

			let $el = $(this);
			$el.addClass("active");
			document.getElementById('invright').style.display = 'block';

		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
			document.getElementById('invright').style.display = 'block';

		}
	})

	$('.item-near').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key'), type: $(this).data('item-type') };

			if (itemData.key === undefined || itemData.type === undefined) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.item-armado').draggable({
		helper: 'clone',
		appendTo: 'body',
		zIndex: 99999,
		revert: 'invalid',
		opacity: 0.5,
		start: function(event,ui){
			$(this).children().children('img').hide();
			itemData = { key: $(this).data('item-key'), type: $(this).data('item-type'), tDrop: $(this).data('item-drop') };

			if (itemData.key === undefined || itemData.type === undefined || itemData.tDrop === undefined ) return;

			let $el = $(this);
			$el.addClass("active");
		},
		stop: function(){
			$(this).children().children('img').show();

			let $el = $(this);
			$el.removeClass("active");
		}
	})

	$('.use').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			$('#confirmar').off();
			itemData = { key: ui.draggable.data('item-key'), type: ui.draggable.data('item-type') };

			if (itemData.key === undefined || itemData.type === undefined) return;
			
			$('.amountBackground').fadeIn(250);
			$('.amountTitleContainer p').text('Usar/Equipar Item (Max 250x)');
			$('#confirmar').click(() => {
				$.post("http://bdl_inventory/useItem", JSON.stringify({
				item: itemData.key,
				type: itemData.type,
				amount: Number($("#amount").val())
			}))
			document.getElementById("amount").value = "";
			$('.amountBackground').fadeOut(250);
			console.log('bdl:inv_system - itemUsed from sourcePlayer')
			})
		}
	})

	$('.send').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			$('#confirmar').off();
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;

			$('.amountBackground').fadeIn(250);
			$('.amountTitleContainer p').text('Enviar Item');
			$('#confirmar').click(() => {
				$.post("http://bdl_inventory/sendItem", JSON.stringify({
				item: itemData.key,
				amount: Number($("#amount").val())
			}))
			document.getElementById("amount").value = "";
			$('.amountBackground').fadeOut(250);
			console.log('bdl:inv_system - itemSend from sourcePlayer to nearEntity')
			})
		}
	})

	$('.drop').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			$('#confirmar').off();
			itemData = { key: ui.draggable.data('item-key') };

			if (itemData.key === undefined) return;
				$('.amountBackground').fadeIn(250);
				$('.amountTitleContainer p').text('Dropar Item')
				$('#confirmar').click(() => {
					$.post("http://bdl_inventory/dropItem", JSON.stringify({
					item: itemData.key,
					amount: Number($("#amount").val())
				}))
				document.getElementById("amount").value = "";
				$('.amountBackground').fadeOut(250);
				console.log('bdl:inv_system - itemDropped from sourcePlayer')
				})
		}
	})

	$('#invleft').droppable({
		hoverClass: 'hoverControl',
		accept: '.item-armado, .item-near',
		drop: function(event,ui){
			itemData = { key: ui.draggable.data('item-key'), tDrop: ui.draggable.data('item-drop') };

			if (itemData.key === undefined || itemData.tDrop === undefined) return;
			$.post("http://bdl_inventory/DoSomething", JSON.stringify({
				tDrop: itemData.tDrop,
				item: itemData.key,
				amount: Number($("#amount").val())
			}))

			document.getElementById("amount").value = "";
		}
	})
}

$('#cancelar').click(function() {
	$('.amountBackground').fadeOut(250);
	$('#confirmar').off();
})

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
	document.getElementById("amount").value = ""
	$.post("http://bdl_inventory/requestMochila",JSON.stringify({}),(data) => {
		const nameList = data.inventario.sort((a,b) => (a.name > b.name) ? 1: -1);
		
		$('#invleft').empty().append(`
			${nameList.map((item) => (`
				<div class="slot"> 
				<span class="tooltiptext"> ${item.name}</span>
                  	<div class="item" data-item-key="${item.key}" data-item-type="${item.type}" data-name-key="${item.name}">
                     	<img class="image" src="http://177.54.158.239/inventory/${item.index}.png"></div>
                     	<div class="quantity">${formatarNumero(item.amount)}x </div>
						<div id="peso">${(item.peso*item.amount).toFixed(1)}</div>
					</div>
			
			`)).join('')}
		`);
	
		
		for (let i = 0; i < data.slots; i++) {
			
			$("#invleft").append(`
				<div class="slot">
				</div>
			`)
		}
		$('#d-peso').html(`
			<div id="peso2" ><div class='esquerdatopo'></div> <div id="livrefundo" ><span id="livre"" ></span></div> <div id="direitatopo"><div class='datapeso'>${data.peso}</div><div class="datamaxpseo">⠀⠀/${data.maxpeso.toFixed(1)}</div></div></div><br><br>

		`);

		if(data.maxpeso == 6){
			$('#livre').css('width',data.peso/0.06+'%');
		  }else{
			$('#livre').css('width',data.peso/0.9+'%');
		  }
		$('#invright').html(`
			<div class="use">
			<div class="margin-to-class"><img src="https://cdn.discordapp.com/attachments/748558542071529483/753280234475880568/1416692.png" style="color:#fff; width: 2vw; margin-top: -0.9vw;"></div>
			</div>
			<div class="send">
			<div class="margin-to-class" style="margin-top:1.01vw;"><img src="https://cdn.discordapp.com/attachments/748558542071529483/753281785567248494/3152818.png" style="color:#fff; width: 2vw; margin-top: -0.5vw;"></div>
			</div>
			<div class="drop">
			   <div class="margin-to-class"><img src="https://cdn.discordapp.com/attachments/748558542071529483/753283360834584696/3159218.png" style="color:#fff; width: 2vw; margin-top: -0.9vw;"></div>

			</div>
		`);
		updateDrag();
	});
}

window.addEventListener('message', (event) => {
	let data = event.data
	if(data.type == 'open') {
		const nome = data.nome + ' ' + data.sobrenome;
		const emprego = data.emprego;
		const carteira = data.carteira;
		const coins = data.coins;
		const banco = data.banco;
		const vip = data.vip;
		const id = data.id;
		const documento = data.documento;
		const idade = data.idade;
		const telefone = data.telefone;
		const position = data.position;
		const multas = data.multas;
		const mypaypal = data.mypaypal;

		$('.emprego span').text(emprego);
		$('.nome span').text(nome);
		$('.carteira span').text('$'+carteira);
		$('.coins span').text(coins);
		$('.banco span').text('$'+banco);
		$('.vip span').text(vip);
		$('.identidade span').text('nº '+id);
		$('.documento span').text(documento);
		$('.idade span').text(idade+' Anos');
		$('.telefone span').text(telefone);
		$('.position span').text(position);
		$('.multas span').text('$'+multas);
		$('.mypaypal span').text(mypaypal);
		$('#identidadeId').fadeIn('fast');
	}
	
	if(data.type == 'close') {
		$('#identidadeId').fadeOut('slow');
	}
});

let isShowing = 0
$('#showInfo').click(() => {
	if (isShowing == 0) {
		$('#first').hide();
		$('#second').show();
		isShowing = isShowing + 1
	} else if (isShowing == 1) {
		$('#second').hide();
		$('#third').show();
		isShowing = isShowing + 1
	} else if (isShowing == 2) {
		$('#third').hide();
		$('#first').show();
		isShowing = 0
	}
})


function botao() {
	$.post("http://bdl_inventory/invClose");
}