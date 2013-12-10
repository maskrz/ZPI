class MessagesController < PortalController
  include MessagesHelper
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @conversations = get_user_conversations(current_user.id)
    @conversation = get_users_conversation(current_user.id, params[:interlocutor_id], 1) if params[:interlocutor_id]
    #@conversations = []
    @messages = Message.all
    @message = Message.new
    #render json: @conversations
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @users = get_recivers_list
    @message = Message.new
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id
    @message.is_read = 0;
    
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_path(:interlocutor_id => @message.reciver_id), success: t('messages.sent') }
        format.json { render action: 'show', status: :created, location: @message }
      else
        format.html { redirect_to messages_path(:interlocutor_id => @message.reciver_id), error: @message.errors.values.join(", ")}
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:content, :reciver_id)
    end
end
