//= require jquery
//= require jquery_ujs
//= require magicsuggest/magicsuggest-1.3.1
//= require bootstrap/bootstrap.min
//= require bootstrap/bootstrap-select
//= require jquery-raty/jquery.raty.min
//= require_directory .
$(document).ready(function() {
	GPW.Common.init();
	GPW.Analysis.init();
	GPW.Home.init();
	GPW.Messages.init();
}); 