class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)

    if comment.save
      redirect_to @post,
        notice: 'Comment was successfully created'
    else
      full_err_msg = '';
      comment.errors.full_messages.each do |msg|
        full_err_msg = full_err_msg + msg + "\n";
      end
      redirect_to @post,
        alert: 'Error in form'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.post, notice: 'Comment was deleted'}
      format.json { head :no_content }
    end
  end 

  def comment_params
    params.require(:comment).permit(:author, :body, :email)
  end
end
