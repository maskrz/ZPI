var GPW = GPW || {};

GPW.Home = {};

GPW.Home.init = function() {
	GPW.Common.scrollTo('#go-further', '#landing-page-main');
	GPW.Common.scrollTo('#register', '#header');
	GPW.Common.scrollTo('#to-data-edition', '#data-edition');
	GPW.Common.scrollTo('#to-change-avatar', '#user-edit');
	GPW.Common.tooltip('#analysis .analysis-header .tooltip-element', { placement : 'right' });
	GPW.Common.tooltip('#content .tab-pane .tooltip-element', { placement : 'left' });
	GPW.Home.scrollListener();
	
	if(GPW.Common.checkIfExists('#user-edit')) {
		$(window).scroll(function(e) {
			$('.fixed-buttons').animate({ 'top' : $(this)[0].scrollY+'px' }, 300);
		});
	}
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
