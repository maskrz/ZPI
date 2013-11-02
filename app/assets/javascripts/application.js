// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

var GPW = {};
GPW.Ajax = {};
GPW.View = {};
GPW.View.Home = {};

GPW.View.scrollTo = function(elem, dest) {
	$(elem).click(function() {
		var scrollTo =  $(dest).offset().top;
		$('html, body').animate({
		    scrollTop : scrollTo
		}, 500);
	});
};
GPW.View.Home.setMainContentPosition = function() {
	var mainContent = $('#landing-page-main');
	var innerHeight = $(window).innerHeight(); //get heigth of shown page part
	var offsetY = mainContent.offset().top;
	if(offsetY < innerHeight) {
		mainContent.css('margin-top',innerHeight-offsetY+'px');
	}
};
GPW.View.Home.scrollListener = function() {
	$(window).scroll(function(e) {
		var offsetY = $(document).scrollTop();
		var visibility = (100 - offsetY*2) / 100;
		$('#go-further').css('opacity', visibility);
	});
};
GPW.Ajax.getCompanies = function() {
	$('select#indices').change(function() {
		var selectedIndex = $(this).val();
		$.get('/index/get_companies', {
			'index_id' : selectedIndex
		}, function(data) {
			console.log(data);
		});
	});
};
