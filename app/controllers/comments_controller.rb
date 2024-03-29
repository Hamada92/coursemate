class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_parent, only: [:create]
  before_action :set_comment, except: [:create]
  before_action :authorize, except: [:create]

  def edit
  end

  def create
    @comment = @parent.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        #seen or unseen by which user?
        CommentStatusCreationService.new(@comment).perform
        format.js
      else
        format.js
      end
    end 
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def set_parent
      if params[:question_id]
        @parent = Question.find(params[:question_id])
        @question = @parent
      elsif params[:answer_id]
        @parent = Answer.find(params[:answer_id])
      elsif params[:group_id]
        @parent = Group.find(params[:group_id])
      end
    end

    def set_comment
      @comment = Comment.find(params[:id])
      if @comment.question_id
        @question = @comment.question
      elsif @comment.answer_id
        @answer = @comment.answer
        @question = @answer.question
      elsif @comment.group_id
        @group = @comment.group
      end
    end 
        
    def comment_params
      params.require(:comment).permit(:body)
    end

    def authorize
      unless @comment.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's comment."
        redirect_to @question
      end
    end

end
