class AnswersController < ApplicationController
  before_action :set_answer, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :authorize, only: [:edit, :update, :destroy]

  def new
    @answer = Answer.new
  end

  def edit
  end

  def create
    @answer = current_user.answers.build(answer_params)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Question was successfully created'}
      else
        format.html { render :new }
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

    def question_params
      params.require(:answer).permit(:body)
    end

    def set_answer
      @question = Question.find(params[:id])
      @answer = @questions.answers.find(params[:id])
    end

    def authorize
      unless @question.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's answer"
        redirect_to @question
      end
    end
end
