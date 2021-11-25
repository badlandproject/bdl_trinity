$(function(){
	init();
	init2()

	var actionContainer = $("#actionmenu");

	window.addEventListener('message',function(event){
		var item = event.data;

		if (item.showmenu){
			ResetMenu()
			$('.confirmScreen').hide()
			actionContainer.fadeIn();
		}

		if (item.hidemenu){
			actionContainer.fadeOut();
		}
	});
})

function ResetMenu(){
	$("div").each(function(i,obj){
		var element = $(this);

		if (element.attr("data-parent")){
			element.hide();
		} else {
			element.show();
		}
	});
}

function init() {
	$(".confirmButton").each(function(i,obj){

		if ($(this).attr("data-action")){
			$(this).click(function(){
				var data = $(this).data("action"); 
				sendData("ButtonClick",data); 
			})
		}

		if ($(this).attr("data-sub")){
			var menu = $(this).data("sub");
			var element = $("#"+menu);

			$(this).click(function(){
				element.show();
				$(this).parent().hide();
			})

			var backBtn = $('<button/>',{text:'Voltar'});

			backBtn.click(function(){
				element.hide();
				$("#"+element.data("parent")).show();
			});

			element.append(backBtn);
		}
	});
}

function init2() {
	$(".menuoption").each(function(i2,obj2){

		if ($(this).attr("data-action2")){
			$(this).click(function(){
				var data = $(this).data("action2");
				sendData("ButtonClick",data); 
			})
		}
	});
}
function sendData(name,data){
	$.post("http://bdl_login/"+name,JSON.stringify(data),function(datab){
		if (datab != "ok"){
			console.log(datab);
		}
	});
}

$('#firstLoc').click(function() {
	$('.confirmScreen').fadeIn();
	$('.confirmTitle p').text('Local - Hospital');
	$('.textDescription p').html('Você irá para o hospital geral de Los Santos, pressione confirmar se você tem certeza !');
	$('.ilustration').attr('src','https://cdn.discordapp.com/attachments/740912067095035955/787096976759980032/unknown.png');
	// Hides //
	$('#hospital').show();
	$('#beach').hide();
	$('#paleto').hide();
	$('#sandys').hide();
	$('#airport').hide();
	$('#lsgarage').hide();
})

$('#secondLoc').click(function() {
	$('.confirmScreen').fadeIn();
	$('.confirmTitle p').text('Local - Praia Vespucci');
	$('.textDescription p').html('Você irá para a praia de Vespucci de Los Santos, pressio-<br>ne confirmar se você tem certeza !');
	$('.ilustration').attr('src','https://cdn.discordapp.com/attachments/740912067095035955/787098660911054848/unknown.png');
	// Hides & Shows //
	$('#beach').show();
	$('#hospital').hide();
	$('#paleto').hide();
	$('#sandys').hide();
	$('#airport').hide();
	$('#lsgarage').hide();
})

$('#thirdLoc').click(function() {
	$('.confirmScreen').fadeIn();
	$('.confirmTitle p').text('Local - Paleto Bay');
	$('.textDescription p').html('Você irá para a cidade de Paleto Bay, pressione confirmar<br> se você tem certeza !');
	$('.ilustration').attr('src','https://cdn.discordapp.com/attachments/740912067095035955/787099072225214464/unknown.png');
	// Hides //
	$('#paleto').show();
	$('#hospital').hide();
	$('#beach').hide();
	$('#sandys').hide();
	$('#airport').hide();
	$('#lsgarage').hide();
})

$('#fourthLoc').click(function() {
	$('.confirmScreen').fadeIn();
	$('.confirmTitle p').text('Local - Sandy Shores');
	$('.textDescription p').html('Você irá para a cidade de Sandy Shores, pressione confir-<br>mar se você tem certeza !');
	$('.ilustration').attr('src','https://cdn.discordapp.com/attachments/740912067095035955/787098139764064256/unknown.png');
	// Hides //
	$('#sandys').show();
	$('#hospital').hide();
	$('#beach').hide();
	$('#paleto').hide();
	$('#airport').hide();
	$('#lsgarage').hide();
})

$('#fifthLoc').click(function() {
	$('.confirmScreen').fadeIn();
	$('.confirmTitle p').text('Local - Aeroporto');
	$('.textDescription p').html('Você irá para o aeroporto internacional de Los Santos, pressione confirmar se você tem certeza !');
	$('.ilustration').attr('src','https://cdn.discordapp.com/attachments/740912067095035955/787041328738336808/b179363f5f1cf7f5fd3d70b496d0fffd.jpg');
	// Hides //
	$('#airport').show();
	$('#hospital').hide();
	$('#beach').hide();
	$('#paleto').hide();
	$('#sandys').hide();
	$('#lsgarage').hide();
})

$('#sixthLoc').click(function() {
	$('.confirmScreen').fadeIn();
	$('.confirmTitle p').text('Local - Garagem');
	$('.textDescription p').html('Você irá para a garagem principal de Los Santos, pressi-<br>one confirmar se você tem certeza !');
	$('.ilustration').attr('src','https://cdn.discordapp.com/attachments/740912067095035955/787099386315538492/unknown.png');
	// Hides //
	$('#lsgarage').show();
	$('#hospital').hide();
	$('#beach').hide();
	$('#paleto').hide();
	$('#sandys').hide();
	$('#airport').hide();
})

$('.cancelButton').click(function() {
	$('.confirmScreen').fadeOut(250);
})

