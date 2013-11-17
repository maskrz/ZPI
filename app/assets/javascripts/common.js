var GPW = GPW || {};

GPW.Common = {};

GPW.Common.checkIfExists = function(element) {
	return $(element).length > 0;
};
GPW.Common.scrollTo = function(element, destination) {
	$(element).click(function(e) {
		e.preventDefault();
		var scrollTo = $(destination).offset().top;
		$('html, body').animate({
			scrollTop : scrollTo
		}, 500);
	});
};
GPW.Common.tooltip = function(element, options){
	$(element).tooltip(options);
};
GPW.Common.rating = function(element, options){
	$(element).raty(options);
};
GPW.Common.autocomplete = function(element, options) {
	$(element).magicSuggest(options);
};
