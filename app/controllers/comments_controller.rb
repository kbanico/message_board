class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_message
  before_action :find_comment, only:[:edit, :update, :destroy]

  def create
    # another way to create comments
    # @message = Message.find(params[:message_id])
    # @comment = @message.comments.create(comment_params)
    # @comment.user_id = current_user

     @comment = @message.comments.create(comment_params.merge(user: current_user))


    if @comment.save
      flash[:success] = "Comment was created"
      redirect_to message_path(@message)
    # else
    #   flash[:warning] = "Comment was not created"
    #   render "new"
    end
  end

  def edit

  end

  def update
    if @comment.update(comment_params)
      redirect_to message_path(@message)
    else
      render "edit"
    end
  end

  def destroy
    @comment.destroy
    redirect_to message_path(@message)
  end



  private
  def find_comment
    @comment = @message.comments.find(params[:id])
  end
  def find_message
    @message = Message.find(params[:message_id])
  end
  def comment_params
    params.require(:comment).permit(:content)
  end
end
