$(document).ready(function() {
	GPW.View.scrollTo('#go-further', '#landing-page-main');
	GPW.View.scrollTo('#register', '#header');
	GPW.View.Home.scrollListener();
	GPW.View.Home.setMainContentPosition();
});

$(window).resize(function(){
	GPW.View.Home.setMainContentPosition();
});