var GPW = GPW || {};

GPW.Ajax = {};
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