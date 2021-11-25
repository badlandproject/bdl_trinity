$(window).load(function() {
  $("#preloader").fadeOut(200);
});

var tips = ['O uso indevido de hack te adicionará no banimento.', 'Você sabia? Identificar um membro de facção apenas pela cor que ele veste é metagaming e está sujeito a banimento!', 'Não pergunte sobre coisas ilegais a qualquer pessoa.', 'Não utilize informações privilegiadas obtidas no Discord ou de algum streamer para se beneficiar na cidade.', 'Leia as regras no nosso Discord e respeite os outros cidadãos.'];
setInterval(function() {
  var r = Math.floor(Math.random() * tips.length);
  $(".tip-text").fadeOut(200, function() {
    $(".tip-text").html(tips[r]);
    $(this).fadeIn(200);
  });
  
}, 10000);

$(function(){   
    $(document).keydown(function(objEvent) {        
        if (objEvent.ctrlKey) {          
            if (objEvent.keyCode == 65) {                         

                return false;
            }            
        }        
    });
}); 