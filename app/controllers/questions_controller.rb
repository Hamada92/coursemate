class QuestionsController < ApplicationController

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created'}
      else
        format.html { render :new }
      end
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  private

    def question_params
      params.require(:question).permit(:title,:body)
    end


end
