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
//= require jquery.bootstrap.wizard
//= require_tree .
//= require bootstrap.min

var GPW = {};
GPW.Ajax = {};
GPW.Util = {};
GPW.View = {};
GPW.View.Home = {};

GPW.Util.checkIfExists = function(element) {
	return $(element).length > 0;
};

GPW.View.scrollTo = function(elem, dest) {
	$(elem).click(function(e) {
		e.preventDefault();
		var scrollTo = $(dest).offset().top;
		$('html, body').animate({
			scrollTop : scrollTo
		}, 500);
	});
};
GPW.View.Home.setMainContentPosition = function() {
	if(GPW.Util.checkIfExists('#landing-page-main')) {
		var mainContent = $('#landing-page-main');
		var innerHeight = $(window).innerHeight();
		//get heigth of shown page part
		var offsetY = mainContent.offset().top;
		if (offsetY < innerHeight) {
			mainContent.css('margin-top', innerHeight - offsetY + 'px');
		}
	}
};
GPW.View.Home.scrollListener = function() {
	if(GPW.Util.checkIfExists('#go-further')) {
		$(window).scroll(function(e) {
			if ($(document).scrollTop() == 0) {
				$('#go-further').fadeIn();
			} else {
				$('#go-further').fadeOut();
			}
		});
	}
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
GPW.Ajax.registration = function(form) {
	_form = $(form);
	_form.submit(function(e) {
		// e.preventDefault();
		var _data = {
			'user' : {
				'first_name' : $(this).find('[name="user[first_name]"]').val(),
				'last_name' : $(this).find('[name="user[last_name]"]').val(),
				'email' : $(this).find('[name="user[email]"]').val(),
				'password' : $(this).find('[name="user[password]"]').val(),
				'password_confirmation' : $(this).find('[name="user[password_confirmation]"]').val(),
				'accept_statuate' : $(this).find('[name="user[accept_statuate]"]').val()
			}
		};
		// $.post('/auth/sign_up', _data, function(response){
		// var _response = JSON.parse(response);
		// console.log(_response);
		// if(_response.status != 'success') {
		// $.each(_response.errors, function(field, error){
		// _form.find('[name="user['+field+']"]').not('[type="hidden"]').each(function(){
		// var baseColor = $(this).css('border-color','red');
		// $(this).css('border-color','red').attr('placeholder',error)
		// .on('keypress click focus', function() {
		// $(this).css('border-color', baseColor);
		// });
		// });
		// });
		// } else {
		//
		// }
		// });
	});
};

GPW.View.Analysis = {};
GPW.View.Analysis.wizardForm = function(wizardFormId) {
}; 