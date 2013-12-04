var GPW = GPW || {};

GPW.Messages = {};

GPW.Messages.init = function() {
	GPW.Messages.selectForUsersList();
	GPW.Messages.scrollToBottom();
	GPW.Messages.loadMessages();
};
GPW.Messages.scrollToBottom = function() {
	$('.conversation .chats').animate({ scrollTop : 9999}, 0);
};

GPW.Messages.selectForUsersList = function() {
	$('#modal').on('shown.bs.modal', function(e){
		$(this).find('select').selectpicker({
	        size: 10
	    });
	});
};

GPW.Messages.countLoadedMessages = function () {
	var result = 0;
	if(GPW.Common.checkIfExists('.conversation .chats')) {
		result = $('.conversation .chats li').length;
	}
	return result;
};

GPW.Messages.loadMessages = function() {
	var loadStatus = '#messages-load-status';
	if(GPW.Common.checkIfExists(loadStatus)) {
		var chat = '.chats';
		var meId = $('.conversation').data('me-id'),
		otherId = $('.conversation').data('other-id');

		GPW.Messages.batch_start = 2;
		$(loadStatus).hide(0);
			
		$(chat).scroll(function(e) {
			if(e.target.scrollTop == 0) {
				$(loadStatus).html('Wczytuję wiadomości...').fadeIn(200);
				var data = { 'batch_start' : GPW.Messages.batch_start, 'interlocutor_id' : otherId };
				
				var beforeLoadHeight = 0;
				$('li', chat).each(function(){
					beforeLoadHeight += $(this).outerHeight();
				});
				
				$.post('/ajax/get_messages', data, function(response){
					$(loadStatus).html('Wczytuję wiadomości...').fadeOut(200);
					GPW.Messages.insertAll(response);
					
					var afterLoadHeight = 0;
					$('li', chat).each(function(){
						afterLoadHeight += $(this).outerHeight();
					});
					
					$(chat).animate({ scrollTop : afterLoadHeight - beforeLoadHeight }, 0);
				
					if(GPW.Messages.allMessagesLoaded()) {
						$(chat).unbind('scroll');
						$(loadStatus).html('Wczytano wszystkie wiadomości.').fadeIn(200);
					}
				});
			}
		});
	}
};

GPW.Messages.insertAll = function(data) {
	var chat = '.chats';
	GPW.Messages.batch_start++;
	for(var i = 0; i < data.length; i++) {
		var message_data = data[i];
		var message = GPW.Messages.create(message_data);
		$(chat).prepend(message);
	}
};

GPW.Messages.create = function(data) {
	var message = $('<li/>');
	var content;
	
	var otherName = $('.conversation').data('other-name'),
		meName = $('.conversation').data('me-name'),
		meAvatar =  $('.conversation').data('me-avatar');
	var meId = $('.conversation').data('me-id'),
		otherId = $('.conversation').data('other-id'),
		otherAvatar =  $('.conversation').data('other-avatar');
	
	if(data.sender_id == otherId) {
		message.addClass('by-other');
		if(otherAvatar.indexOf('default') != -1) {
			message.append('<div class="avatar pull-left"><span class="glyphicon glyphicon-user"></span></div>');
		} else {
			message.append('<div class="avatar pull-left"><img class="img-rounded" src="'+otherAvatar+'"></div>');
		}
		content = $('<div class="chat-content"/>');
		content.append('<div class="chat-meta">'+otherName+' <span class="pull-right">'+data.created_at+'</span></div>');
	
	} else {
		message.addClass('by-me');
		if(meAvatar.indexOf('default') != -1) {
			message.append('<div class="avatar pull-right"><span class="glyphicon glyphicon-user"></span></div>');
		} else {
			message.append('<div class="avatar pull-right"><img class="img-rounded" src="'+meAvatar+'"></div>');
		}
		content = $('<div class="chat-content"/>');
		content.append('<div class="chat-meta">'+data.created_at+' <span class="pull-right">'+meName+'</span></div>');
	}
	content.append('<p>'+data.content+'</p>');
	content.appendTo(message);
	message.append('<div class="clearfix"></div>');
	return message;
};

GPW.Messages.allMessagesLoaded = function() {
	return $('.conversation').data('total-messages') == GPW.Messages.countLoadedMessages();
};
