$(document).ready(function() {
	$('select#indices').change(function() {
		var selectedIndex = $(this).val();
		$.get('/index/get_companies', {
			'index_id' : selectedIndex
		}, function(data) {
			console.log(data);
		});
	});
	$('#go-further').click(function() {
		var scrollTo =  $('#landing-page-main').offset().top;
		$('html, body').animate({
		    scrollTop : scrollTo
		}, 1000);
	});
});
