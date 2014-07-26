class MessagesController < ApplicationController
  def index
    authorize! :index, Channel
    @messages = Message.where('user_id = ?', current_user.id)
  end

  def show
    @message = Message.find(params[:id])
    authorize! :show, @message
    @message.seen = true
    @message.save
  end

  def new
    authorize! :index, Channel
    if params[:id]
      @user_id = params[:id]
    end
  end

  def create
    authorize! :create, Channel
    message = Message.new(params[:message].permit(:user_id, :title, :message))
    message.owner_id = current_user.id
    if message.save
      flash[:notice] = 'Ok'
    else
      flash[:alert] = 'Ko'
    end
    redirect_to messages_path
  end

  def destroy
    message = Message.find(params[:id])
    authorize! :manage, message
    message.destroy
    flash[:notice] = 'Ok'
    redirect_to messages_path
  end
end
