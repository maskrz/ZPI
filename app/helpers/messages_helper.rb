module MessagesHelper
  def get_recivers_list
    User.where.not(:id => current_user.id).map{|user| [user.last_name+' '+user.first_name, user.id]}
  end
  def user_messages(id)
    Message.where('sender_id = :id OR reciver_id=:id', { :id => id })
  end
  def conversation_messages(user_id, interlocutor_id, batch_start = 1)
    batch_size = 5
    batch_offset = (batch_start - 1) * batch_size 
    participants = [user_id, interlocutor_id]
    Message.where(:sender_id => participants, :reciver_id => participants).order(created_at: :desc).limit(batch_size).offset(batch_offset).reverse
  end
  def get_users_conversation(user_id, interlocutor_id, batch_start)
    {}.tap do |result|
      result[:messages] = conversation_messages(user_id, interlocutor_id, batch_start)
      result[:total_messages] = Message.where(:sender_id => [user_id, interlocutor_id], :reciver_id => [user_id, interlocutor_id]).count
      result[:interlocutor] = User.where(:id => interlocutor_id).first
    end
  end
  def get_user_conversations(id)
    [].tap do |result|
      get_interlocutors(id).each do |interlocutor|
        last_conversation = {}
        last_conversation[:interlocutor] = interlocutor
        last_conversation[:last_message] = conversation_messages(id, interlocutor.id).last
        result << last_conversation
      end
    end
  end
  
  def get_message_direction(my_id, sender_id)
    if my_id == sender_id
      1
    else
      -1
    end
  end
  
  def get_interlocutors(id)
    {}.tap do |result|
      user_messages(id).order(created_at: :desc).select(:reciver_id, :sender_id).each do |message|
        if message.reciver_id != id
          interlocutor_id = message.reciver_id
        else
          interlocutor_id = message.sender_id
        end
        result.store(interlocutor_id, User.where(:id => interlocutor_id)) unless result.include?(interlocutor_id)
      end
    end.values.flatten(1)
  end
end
