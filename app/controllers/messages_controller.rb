class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @room
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast("everyone",
        render_to_string(partial: 'message', locals: {message: @message} ))
        redirect_to chatroom_path(@room, anchor: "message-#{@message.id}")
    else
      render 'chatrooms/show'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end






# if @message.save
#   roomChannel.broadcast_to(
#     @chatroom,
#     render_to_string(partial: "message", locals: {message: @message})
#   )
#   head :ok
# else
