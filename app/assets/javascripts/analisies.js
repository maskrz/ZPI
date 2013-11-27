var GPW = GPW || {};

GPW.Analysis = {};

GPW.Analysis.init = function(){
	GPW.Analysis.Wizard.init();
	GPW.Analysis.Rating.init();
	GPW.Analysis.Wall.init();
};

GPW.Analysis.Wall = {};
GPW.Analysis.Wall.init = function() {
	GPW.Analysis.Wall.page = 1;
	GPW.Analysis.Wall.filters = [];
	GPW.Analysis.Wall.addListeners();
	GPW.Analysis.Wall.initFilters();
	GPW.Analysis.Wall.pageLoad();
};
GPW.Analysis.Wall.initFilters = function() {
	$('.filters #companies-list').hide(0);
	GPW.Ajax.getIndices().success(function(response){
		$('.filters #indices-list select').html('<option value="0">---</option>');
		$.each(response, function(){
        	$('.filters #indices-list select').append('<option value="'+ this.id +'">'+ this.name +'</option>');
        });
        $('.filters #indices-list select').selectpicker({ width:'100%','size': 10});
	});
	$('.filters #indices-list select').change(function() {
		var indexId = $(this).val();
		GPW.Analysis.Wall.getCompanies(indexId);
	});
	$('.filters button').click(function(){
		var filterBy = {};
		var indexId = $('.filters #indices-list select').val();
		var companyId = $('.filters #companies-list select').val();
		if(companyId != undefined && companyId != 0) {
			GPW.Analysis.Wall.filters = ['company', companyId];
		} else if (indexId != undefined && indexId != 0) {
			GPW.Analysis.Wall.filters = ['index', indexId];
		} else {
			alert('Nie wybrano kryteriów do filtorwania');
			return;
		}
		GPW.Analysis.Wall.page = 1;
		GPW.Analysis.Wall.changePage();
	});
};

GPW.Analysis.Wall.getCompanies = function(index_id){
	GPW.Ajax.getCompanies(index_id).success(function(response){
		$('.filters #companies-list select').html('<option value="0">---</option>');
		$.each(response, function(){
        	$('.filters #companies-list select').append('<option value="'+ this.id +'">'+ this.name +'</option>');
        });
        $('.filters #companies-list select').selectpicker({'size': 10});
        $('.filters #companies-list select').selectpicker('refresh');
        $('.filters #companies-list').slideDown(500);
	});
};

GPW.Analysis.Wall.addListeners = function() {
	$('#wall').on('click', '.pagination li span', function(){
		var that = $(this);
		var pageNo = parseInt(that.html());
		if(!isNaN(pageNo)) {
			var parent = that.parent();
			$('#wall .pagination li').not(parent).removeClass('active');
			parent.addClass('active');
			$('#wall .analysis-list').css('opacity', '.5');
			
			GPW.Analysis.Wall.page = pageNo;
			GPW.Analysis.Wall.changePage();
		}
	});
};

GPW.Analysis.Wall.dateSwitch = function() {
	$('.selectpicker').each(function() {
		$(this).selectpicker({ width:'100%'});
		$(this).change(function(){
			var parent = $(this).parent().parent().parent();
			var company_id = $(this).data('companyid');
			var date = $(this).val();
			
			var data = { 'company_id' : company_id, 'date' : date };
			
			$.get('/ajax/get_user_company_analysis_for_day', data, function(response) {
				var filtered_response = $(response).html();
				parent.find('.analysis-content').html(filtered_response);
			});
		});
	});
};

GPW.Analysis.Wall.changePage = function() {
	var pageNo = GPW.Analysis.Wall.page;
	var filters = GPW.Analysis.Wall.filters;
	var data = { 'page_no' : pageNo, 'filters' : filters };
	
	$.get('/ajax/get_user_analysis_history', data, function(response){
		var res = $(response).find('#analysis-items').html();
		$('#wall #analysis-items').css('opacity','1').html(res);
		GPW.Analysis.Wall.pageLoad();
	});
};

GPW.Analysis.Wall.pageLoad = function() {
	GPW.Analysis.Wall.dateSwitch();
	GPW.Analysis.Wall.setPager(GPW.Analysis.Wall.page);
};
GPW.Analysis.Wall.setPager = function(pageNo) {
	var active;
	$('#wall .pagination li').each(function(){
		var thisNo = parseInt($(this).find('span').html());
		if(thisNo == pageNo) {
			active = $(this).addClass('active');
		}
	});
	$('#wall .pagination li').not(active).removeClass('active');
};

GPW.Analysis.Rating = {};
GPW.Analysis.Rating.init = function() {
	$('.rating').each(function() {
		GPW.Common.rating(this, {});
	});
};

GPW.Analysis.Wizard = {};

// wizard nav buttons pager
GPW.Analysis.Wizard.Navi = {};
GPW.Analysis.Wizard.Navi.init = function() {
	$('.wizard .pager').on('click', '.submit', function(e){
		e.preventDefault();
		if(GPW.Analysis.Wizard.valid()) {
			GPW.Analysis.Wizard.submit();
		}
	});
	
	var prevBtn = $('.wizard .step.previous');
	var nextBtn = $('.wizard .step.next');
	
	prevBtn.on('click', function(e){
		e.preventDefault();
		GPW.Analysis.Wizard.Navi.step(-1);
	});
	nextBtn.on('click', function(e){
		e.preventDefault();
		GPW.Analysis.Wizard.Navi.step(1);
	});
};
GPW.Analysis.Wizard.Navi.step = function(way) {
	var current = $('.wizard .nav-tabs li.active');
	var nextId = way == -1 ? current.index()-1 : current.index()+1;
	
	if(nextId < 0) {
		nextId = 0;
	}
	if(nextId > 2) {
		nextId = 2;
	}
	
	if(GPW.Analysis.Wizard.checkTab(current.index())) {
		GPW.Analysis.Wizard.showTab(nextId);
	}
	// GPW.Analysis.Wizard.Navi.markPreviousTabs(nextId);
};

// GPW.Analysis.Wizard.Navi.markPreviousTabs = function(tabId) {
	// $('.wizard .nav-tabs li').removeClass('marked');
	// for(var i = 0; i < tabId; i++) {
		// $('.wizard .nav-tabs li').eq(i).addClass('marked');
	// }
// };

GPW.Analysis.Wizard.init = function() {
	GPW.Analysis.Wizard.initializedTabs = [false, false, false];
  	if(GPW.Common.checkIfExists('.wizard')) {
  		GPW.Analysis.Wizard.splitTabs();
  		GPW.Analysis.Wizard.disableTabs();
  		GPW.Analysis.Wizard.Navi.init();
		GPW.Analysis.Wizard.showTab(0);
		GPW.Analysis.Wizard.showAdviceForTab(0);
  	};
};

GPW.Analysis.Wizard.submit = function() {
	var result = {};
	result.companies = GPW.Analysis.Wizard.companies();
	result.periods = GPW.Analysis.Wizard.periods();
	
	$.post('/ajax/order_analysis', result, function(response) {
		//console.log(response);
		window.location.href = '/home/wall';
	});
};

GPW.Analysis.Wizard.disableTabs = function() {
	$(document).off('click.bs.tab.data-api', '[data-toggle="tab"], [data-toggle="pill"]');
	$(document).on('click.bs.tab.data-api', '[data-toggle="tab"], [data-toggle="pill"]', function(e) {
		e.preventDefault();
	});
};

GPW.Analysis.Wizard.splitTabs = function() {
	$('.wizard .nav-tabs').each(function(){
		var items = $('li', this);
		var itemsNum = items.length;
		var percentageWidth = Math.round(100/itemsNum*100000000)/100000000;
		items.css('width',percentageWidth+'%');
	});
};

GPW.Analysis.Wizard.showTab = function(tabId) {
	GPW.Analysis.Wizard.beforeShowTab(tabId);
	GPW.Analysis.Wizard.showAdviceForTab(tabId);
	$('.wizard .nav-tabs li a').eq(tabId).tab('show');
};

GPW.Analysis.Wizard.beforeShowTab = function(tabId) {
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
		
				$('.wizard .step.previous').css('visibility','visible');
				$('.wizard .step.next a').html('Następny krok').removeClass('submit');
			} break;
			case 2 : {
				$('.wizard .step.previous').css('visibility','visible');
				$('.wizard .step.next a').html('Gotowe').addClass('submit');
			} break;
			default : { //first tab
				$('.wizard .step.previous').css('visibility','hidden');
				$('.wizard .step.next a').html('Następny krok').removeClass('submit');
				GPW.Ajax.getIndices().success(function(response){ //fetch data first
					autocompleteOptions.data = response;
					GPW.Common.autocomplete('#indices-list', autocompleteOptions);
				});
			} break;
			//GPW.Analysis.Wizard.initializedTabs[tabId] = true;
		}
	}
};

GPW.Analysis.Wizard.valid = function() {
	return GPW.Analysis.Wizard.checkTab(0) && GPW.Analysis.Wizard.checkTab(1) && GPW.Analysis.Wizard.checkTab(2);
};

GPW.Analysis.Wizard.checkTab = function(tabId) {
	switch(tabId) {
		case 1 : {
			return GPW.Analysis.Wizard.companies() != undefined;
		} break;
		case 2 : {
			return GPW.Analysis.Wizard.periods() != undefined;
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
GPW.Analysis.Wizard.periods = function() {
	var result = [];
	$('#tab3 .checkboxes label.active').each(function(){
		result.push($(this).find('input').val());
	});
	return result.length != 0 ? result : undefined;
};
