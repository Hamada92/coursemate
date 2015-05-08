class AnswersController < ApplicationController
  before_action :set_question
  before_action :authenticate_user!
  before_action :authorize, only: [:edit, :update, :destroy]

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created'}
      else
        format.html { render 'questions/show' }
      end
    end
  end

  def update
      if @answer.update(answer_params)
        redirect_to @question, notice: "Question successfully updated" 
      else
        render :edit
      end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html {redirect_to @question, notice: 'questions was deleted'}
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:body)
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

=begin
    def set_answer
      @question = Question.find(params[:question_id])
      @answer = @question.answers.find(params[:id])
    end

    def authorize
      unless @question.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's answer"
        redirect_to @question
      end
    end
=end
end
