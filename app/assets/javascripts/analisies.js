var GPW = GPW || {};

GPW.Analysis = {};

GPW.Analysis.init = function(){
	GPW.Analysis.wizard();
};

GPW.Analysis.wizard = function() {
  	if(GPW.Common.checkIfExists('.wizard')) {
  		//$('.wizard').bootstrapWizard();
  		$('.wizard .nav-tabs').each(function(){
  			var items = $('li', this);
  			var itemsNum = items.length;
  			var percentageWidth = Math.round(100/itemsNum*100000000)/100000000;
  			items.css('width',percentageWidth+'%');
  		});
  	};
};