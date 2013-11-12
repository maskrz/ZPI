$(document).ready(function() {
	GPW.View.scrollTo('#go-further', '#landing-page-main');
	GPW.View.scrollTo('#register', '#header');
	GPW.View.Home.scrollListener();
	GPW.View.Home.setMainContentPosition();

	GPW.View.setTooltip('#user_box .nav .dropdown-toggle', { placement : 'top' });
	GPW.View.setTooltip('#analysis_header .tooltip-element', { placement : 'top' });
});

$(window).resize(function(){
	GPW.View.Home.setMainContentPosition();
});