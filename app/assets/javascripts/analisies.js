$(document).ready(function() {
  	$('#rootwizard').bootstrapWizard({'tabClass': 'nav nav-pills'});
  	
  	if(GPW.Util.checkIfExists('.wizard')) {
  		$('.wizard .nav-tabs').each(function(){
  			var items = $('li', this);
  			var itemsNum = items.length;
  			var percentageWidth = Math.round(100/itemsNum*100000000)/100000000;
  			items.css('width',percentageWidth+'%');
  		});
  	}
});