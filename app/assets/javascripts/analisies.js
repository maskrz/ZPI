var GPW = GPW || {};

GPW.Analysis = {};

GPW.Analysis.init = function(){
	GPW.Analysis.Wizard.init();
	GPW.Analysis.Rating.init();
};

GPW.Analysis.Rating = {};
GPW.Analysis.Rating.init = function() {
	$('.rating').each(function() {
		GPW.Common.rating(this, {});
	});
};

GPW.Analysis.Wizard = {};
GPW.Analysis.Wizard.init = function() {
	GPW.Analysis.Wizard.initializedTabs = [false, false, false];
  	if(GPW.Common.checkIfExists('.wizard')) {
  		GPW.Analysis.Wizard.splitTabs();
  		GPW.Analysis.Wizard.setTabsListener();
		GPW.Analysis.Wizard.initTab(0);
		GPW.Analysis.Wizard.showAdviceForTab(0);
  	};
};

GPW.Analysis.Wizard.splitTabs = function() {
	$('.wizard .nav-tabs').each(function(){
		var items = $('li', this);
		var itemsNum = items.length;
		var percentageWidth = Math.round(100/itemsNum*100000000)/100000000;
		items.css('width',percentageWidth+'%');
	});
};

GPW.Analysis.Wizard.setTabsListener = function() {
	$('.wizard .nav-tabs').on('show.bs.tab', 'a', function (e) {
		var prev = $(e.relatedTarget);
		var next = $(e.target);
		var prevId = prev.parent().index();
		var nextId = next.parent().index();
		
		if(prevId + 1 == nextId) {
			if(GPW.Analysis.Wizard.checkTab(prevId)) {
				GPW.Analysis.Wizard.initTab(nextId);
			}
		}
		GPW.Analysis.Wizard.showAdviceForTab(nextId);
	});
};

GPW.Analysis.Wizard.initTab = function(tabId) {
	if(!GPW.Analysis.Wizard.initializedTabs[tabId]) {
		var autocompleteOptions = {
		    width: '100%',
		    sortOrder: 'name',
		    selectionPosition: 'bottom',
		    selectionStacked: true,
		    displayField: 'name'
		};
		switch(tabId) {
			case 1 : {
				var indices = $('#ms-sel-ctn-0 > input[type="hidden"]').val();
				indices = JSON.parse(indices);
				GPW.Ajax.getCompanies(GPW.Analysis.Wizard.indices()).success(function(response){
					autocompleteOptions.data = response;
					GPW.Common.autocomplete('#companies-list', autocompleteOptions);
				});
			} break;
			case 2 : {
				
			} break;
			default : { //first tab
				GPW.Ajax.getIndices().success(function(response){ //fetch data first
					autocompleteOptions.data = response;
					GPW.Common.autocomplete('#indices-list', autocompleteOptions);
				});
			} break;
			GPW.Analysis.Wizard.initializedTabs[tabId] = true;
		}
	}
};

GPW.Analysis.Wizard.checkTab = function(tabId) {
	switch(tabId) {
		case 1 : {
			return GPW.Analysis.Wizard.companies() != undefined;
		} break;
		case 2 : {
			
		} break;
		default : { //first tab
			return GPW.Analysis.Wizard.indices() != undefined;
		}
	}
};
GPW.Analysis.Wizard.showAdviceForTab = function(tabId) {
	$('#advice-place .advice').not('#advice-'+tabId).fadeOut(200, function() {
		$('#advice-'+tabId).fadeIn(200);
	});
};
GPW.Analysis.Wizard.indices = function() {
	var result = $('#ms-sel-ctn-0 > input[type="hidden"]').val();
	return result != undefined ? JSON.parse(result) : result;
};
GPW.Analysis.Wizard.companies = function() {
	var result = $('#ms-sel-ctn-1 > input[type="hidden"]').val();
	return result != undefined ? JSON.parse(result) : result;
};
