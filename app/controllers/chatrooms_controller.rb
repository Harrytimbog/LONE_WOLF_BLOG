class ChatroomsController < ApplicationController
  skip_after_action :verify_policy_scoped, only: :index

  def index
    @chatrooms = Chatroom.all
    authorize @chatrooms
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end
end
