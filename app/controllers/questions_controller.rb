class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: "Question successfully updated" }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_path, notice: 'questions was deleted' }
    end
  end

  def unanswered
    @unanswered_questions = Question.unanswered
  end

  def show_with_tag
    if params[:course_number]
      @questions_with_tag = Question.from_course(params[:course_name], params[:course_number])
    else
      @questions_with_tag = Question.from_subject(params[:course_name])
    end
  end

  def show_from_course
    @questions_with_tag = Question.from_course(params[:course_name], params[:course_number])
  end

  private

    def question_params
      params.require(:question).permit(:title, :body, :course_name, :course_number)
    end

    def set_question
      @question = Question.find(params[:id])
    end

    def authorize
      unless @question.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's question"
        redirect_to @question
      end
    end

end
