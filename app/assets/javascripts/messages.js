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
	if(GPW.Common.checkIfExists('#messages-load-status')) {
		GPW.Messages.batch_start = 2;
		
		var otherId = $('.conversation').data('other-id'),
			otherName = $('.conversation').data('other-name'),
			meId = $('.conversation').data('me-id'),
			meName = $('.conversation').data('me-name');

			$('#messages-load-status').hide(0);
			
		$('.chats').scroll(function(e) {
			if(e.target.scrollTop == 0) {
				$('#messages-load-status').html('Wczytuję wiadomości...').fadeIn(200);
				var data = { 'batch_start' : GPW.Messages.batch_start, 'interlocutor_id' : otherId };
				
				var beforeLoadHeight = 0;
				$('.chats li').each(function(){
					beforeLoadHeight += $(this).outerHeight();
				});
				
				$.post('/ajax/get_messages', data, function(response){
					GPW.Messages.batch_start++;
					for(var i = 0; i < response.length; i++) {
						var message_data = response[i];
						var message = $('<li/>');
						
						var message_class;
						var content;
						if(message_data.sender_id == otherId) {
							message.addClass('by-other');
							message.append('<div class="avatar pull-left"><span class="glyphicon glyphicon-user"></span></div>');
							content = $('<div class="chat-content"/>');
							content.append('<div class="chat-meta">'+otherName+' <span class="pull-right">'+message_data.created_at+'</span></div>');
						
						} else {
							message.addClass('by-me');
							message.append('<div class="avatar pull-right"><span class="glyphicon glyphicon-user"></span></div>');
							content = $('<div class="chat-content"/>');
							content.append('<div class="chat-meta">'+message_data.created_at+' <span class="pull-right">'+meName+'</span></div>');
						}
						content.append('<p>'+message_data.content+'</p>');
						content.appendTo(message);
						message.append('<div class="clearfix"></div>');
						$('.conversation .chats').prepend(message);
					}
					
					$('#messages-load-status').html('Wczytuję wiadomości...').fadeOut(200);
					
					var afterLoadHeight = 0;
					$('.chats li').each(function(){
						afterLoadHeight += $(this).outerHeight();
					});
					
					$('.conversation .chats').animate({ scrollTop : afterLoadHeight - beforeLoadHeight }, 0);
				
					if(GPW.Messages.allMessagesLoaded()) {
						$('.chats').unbind('scroll');
						$('#messages-load-status').html('Wczytano wszystkie wiadomości.').fadeIn(200);
					}
				});
			}
		});
	}
};

GPW.Messages.allMessagesLoaded = function() {
	return $('.conversation').data('total-messages') == GPW.Messages.countLoadedMessages();
};
