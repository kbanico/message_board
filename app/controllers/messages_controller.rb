class MessagesController < ApplicationController
  before_action :find_message, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @messages = Message.all

  end

  def show
    @message = Message.find(params[:id])
    @comment = Comment.new
  end

  def new
    @message = Message.new

  end

  def create
    @message= current_user.messages.create(message_params)
    if @message.save
      flash[:info] = "Your Message Was Created"
      redirect_to root_path
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @message.update(message_params)
      flash[:info] = "Your Message Was Updated"
      redirect_to message_path(@message)
    else
      flash[:alert] = "Your Message Was Not Saved"
      render "edit"
    end
  end

  def destroy
    @message.destroy
    flash[:info] = "Your Message Was Succesfully Deleted"
    redirect_to root_path
  end



  private
  def message_params
    params.require(:message).permit(:title, :description)
  end

  def find_message
    @message = Message.find(params[:id])

  end

end
