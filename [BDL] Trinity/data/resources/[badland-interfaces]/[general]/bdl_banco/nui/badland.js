$(".txtb input").on("focus",function(){
    $(this).addClass("focus");
});

$(".txtb input").on("blur",function(){
    if($(this).val() == "")
    $(this).removeClass("focus");
});

function addCommas(nStr) {
  nStr += '';
  var x = nStr.split('.');
  var x1 = x[0];
  var x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
      x1 = x1.replace(rgx, '$1' + '.<span style="margin-left: 0px; margin-right: 1px;"/>' + '$2');
  }
  return x1 + x2;
}
let mostrando = false;
$(function() {
    window.addEventListener('message', function(event) {
		let item = event.data
        if (event.data.type === "openGeneral"){
           
            $('#focus').fadeIn(500);
            $('#login').fadeIn(500);
			if (event.data.isATM) {
				$('.depositButton').hide();
                $('.citationButton').hide();
				if (mostrando == false) {
					$('.userInfos').hide();
					$('.infosClose').hide();
					$('.infosArrow').show();
				} else {
					$('.userInfos').hide();
					$('.infosClose').hide();
					$('.infosArrow').show();
				}
				
				
                $('.sacarButton').css("top", "0vw");
                $('.transferButton').css("top", "7vw");
                $('#titleMainMenu').html('Bem-Vindo - ATM');
                
            }
			else {
				if (mostrando == false) {
					$('.userInfos').hide();
					$('.infosClose').hide();
					$('.infosArrow').show();
				} else {
					$('.userInfos').hide();
					$('.infosClose').hide();
					$('.infosArrow').show();
				}
				$('.depositButton').show();
                $('.citationButton').show();
                $('.sacarButton').css("top", "7vw");
                $('.transferButton').css("top", "14vw");
                $('#titleMainMenu').html('Bem-Vindo - Agência');
			}
			
		let banco_data = item.banco
          for (let item in banco_data) {
              $("#extrato").append(`
              <div class="userHistoryMargin">
                  <div class="card-content__title">Extrato (` + banco_data[item].data + `)</div>
                  <div class="card-content__value"><span>` + banco_data[item].extrato + `</span></div>
              </div>
            `);
            console.log(banco_data+'JS recebido')
          }
            
            $('body').addClass("active");
        } else if(event.data.type === "balanceHUD") {
                $('.username1').html(event.data.player);
                $('.balance').html('$ '+event.data.balance);
                $('.walletBalance').html('$ '+event.data.wallet);
                $('.citationBalance').html('$ '+event.data.citation);
                
        } else if (event.data.type === "closeAll"){
            $('#waiting, #general, #transferUI, #sacarUI,#multarUI, #depositarUI, #login').fadeOut(250);
            $('#extrato').html('')
            $('body').removeClass("active");
        }
    });
});

window.addEventListener('message', function(event) {
    var item = event.data;


    if (item.openBank == true) {
        $(".container").fadeIn();

        let banco_data = item.banco
        for (let item in banco_data) {
            $("#extrato").append(`
            <div class="margin">
                <div class="card-content__title"><b>Extrato(` + banco_data[item].data + `)</b></div>
                <div class="card-content__value"><span>` + banco_data[item].extrato + `</span></div>
            </div>
          `);
        }
    }

    if (item.openBank == false) {
        $('#extrato').html('')
    }
});

window.addEventListener('message', (event) => {
    let data = event.data
    if(data.type == 'open') {
        const nome = data.nome + ' ' + data.sobrenome;
        const login = data.sobrenome.toLowerCase() + '_' + data.nome.toLowerCase() +'@fleeca.net';
        const emprego = data.emprego;
        const carteira = data.carteira;
        const coins = data.coins;
        const vip = data.vip;
        const id = data.id;
        const documento = data.documento;
        const idade = data.idade;
        const telefone = data.telefone;
        const multas = data.multas;
        const mypaypal = data.mypaypal;

        $('.emprego span').text(emprego);
        $('.loginUsername span').text(login);
        $('.nome span').text(nome);
        $('.carteira span').text('$'+carteira);
        $('.coins span').text(coins);
        $('.vip span').text(vip);
        $('.identidade span').text('No. '+id);
        $('.documento span').text(documento);
        $('.idade span').text(idade+' Anos');
        $('.telefone span').text(telefone);
        $('.multas span').text(multas);
        $('.mypaypal span').text(mypaypal);
        $('#identidadeId').fadeIn('fast');
    }
    
    if(data.type == 'close') {
        $('#identidadeId').fadeOut('slow');
    }
});



$('#closeMenu').click(function(){
    $('#waiting, #transferirUI, #sacarUI, #multarUI ,#depositarUI').fadeOut(250);
	$('#login').fadeIn(250)
})
$('.backwards').click(function(){
    $('#general,#focus, #waiting, #transferirUI, #sacarUI, #multarUI ,#depositarUI, #login').fadeOut(250);
    $('body').removeClass("active");
    $.post('http://bdl_banco/NUIFocusOff', JSON.stringify({}));
})

$('.infosArrow').click(() => {
        $('.userInfos').slideDown(500);
        mostrando = true;
        $('.infosClose').fadeIn();
        $('.infosArrow').fadeOut();
});
$('.infosClose').click(() => {
        $('.userInfos').slideUp();
        mostrando = false;
        $('.infosClose').fadeOut(200);
        $('.infosArrow').delay(500);
		$('.infosArrow').fadeIn(200);
});  
   
$('#back').click(function(){
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').fadeOut();
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').hide(50);
    $('#general').show();
})
$('#back1').click(function(){
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').fadeOut();
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').hide(50);
    $('#general').show();
})
$('#back2').click(function(){
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').fadeOut();
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').hide(50);
    $('#general').show();
})
$('#back3').click(function(){
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').fadeOut();
    $('#depositarUI, #sacarUI, #transferirUI, #multarUI').hide(50);
    $('#general').show();
})
$('.depositButton').click(function(){
    $('#depositarUI').fadeIn();
    $('#depositarUI').show(50);
})
$('.sacarButton').click(function(){
    $('#sacarUI').fadeIn();
    $('#sacarUI').show(50);
})
$('.transferButton').click(function(){
    $('#transferirUI').fadeIn();
    $('#transferirUI').show(50);
})
$('.citationButton').click(function(){
    $('#multarUI').fadeIn();
    $('#multarUI').show(50);
})
$('.loginButton').click(function(){
    $('#login').fadeOut(500);
    $('#general').show();
})

$("#depositar1").submit(function(e) {
    e.preventDefault();
    $.post('http://bdl_banco/depositar', JSON.stringify({
        amount: $("#amount").val()
    }));
    $('#depositarUI').fadeOut();
    $('#depositarUI').hide(50);
    $('#general').show();
    $("#amount").val('');
});
$("#sacar1").submit(function(e) {
    e.preventDefault();
    $.post('http://bdl_banco/sacar', JSON.stringify({
        amounts: $("#amounts").val()
    }));
    $('#sacarUI').fadeOut();
    $('#sacarUI').hide(50);
    $('#general').show();
    $("#amounts").val('');
});
$("#multa1").submit(function(e) {
    e.preventDefault();
    $.post('http://bdl_banco/multa', JSON.stringify({
        amountm: $("#amountm").val()
    }));
    $('#multarUI').fadeOut();
    $('#multarUI').hide(50);
    $("#amountm").val('');
});
$("#transferir1").submit(function(e) {
    e.preventDefault();
    $.post('http://bdl_banco/transferir', JSON.stringify({
        to: $("#to").val(),
        amountt: $("#amountt").val()
    }));
    $('#transferirUI').fadeOut();
    $('#transferirUI').hide(50);
    $('#general').show();
    $("#to").val('');
    $("#amountt").val('');
});
document.onkeyup = function(data){
    if (data.which == 27){
        $('#general,#focus, #waiting, #transferirUI, #sacarUI, #depositarUI, #multarUI, #login').fadeOut(250);
        $('body').removeClass("active");
        $.post('http://bdl_banco/NUIFocusOff', JSON.stringify({}));
    }
}