var GPW = GPW || {};

GPW.Ajax = {};
GPW.Ajax.getIndices = function() {
	return $.get('/ajax/get_indices');
};
GPW.Ajax.getCompanies = function(indices) {
	return $.get('/ajax/get_companies', { 'indices' : indices});
};

