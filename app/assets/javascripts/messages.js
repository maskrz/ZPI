var GPW = GPW || {};

GPW.Messages = {};

GPW.Messages.init = function() {
	GPW.Messages.selectForUsersList();
};
GPW.Messages.selectForUsersList = function() {
	$('#modal').on('shown.bs.modal', function(e){
		$(this).find('select').selectpicker({
	        size: 10
	    });
	});
};