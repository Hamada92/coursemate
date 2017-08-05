class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, except: [:create]
  before_action :set_question, only: [:create]
  before_action :authorize, except: [:create]

  def edit
  end

  def create
    answer = @question.answers.build(answer_params)
    answer.user = current_user
    respond_to do |format|
      if answer.save
        Notification.create!(answer_id: answer.id) unless answer.user_id == @question.user_id
        @answer = AnswerShow.find(answer.id) #AnswerShow is a view-backed model.
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to question_path(@question.id), notice: "Answer successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def answer_params
      params.require(:answer).permit(:body)
    end

    def set_question
      @question = Question.find(params[:question_id])
    end

    def set_answer
      @answer = Answer.find(params[:id])
      @question = QuestionShow.find(@answer.question_id)
    end

    def authorize
      unless @answer.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's answer."
        redirect_to @question
      end
    end
end
