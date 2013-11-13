var GPW = GPW || {};

GPW.Home = {};

GPW.Home.init = function() {
	GPW.Common.scrollTo('#go-further', '#landing-page-main');
	GPW.Common.scrollTo('#register', '#header');
	GPW.Common.tooltip('#user_box .nav .dropdown-toggle', { placement : 'top' });
	GPW.Common.tooltip('#analysis_header .tooltip-element', { placement : 'top' });
	GPW.Home.scrollListener();
};

GPW.Home.scrollListener = function() {
	if(GPW.Common.checkIfExists('#go-further')) {
		var goFurther = $('#go-further');
		var mainContent = $('#landing-page-main');
		if(mainContent.offset().top < goFurther.offset().top) {
			goFurther.remove();
		} else {
			$(window).scroll(function(e) {
				if ($(document).scrollTop() == 0) {
					goFurther.fadeIn();
				} else {
					goFurther.fadeOut();
				}
			});
		}
	}
};
