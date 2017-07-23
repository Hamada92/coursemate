class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :show_from_my_university]
  before_action :set_question, only: [:edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :set_autocomplete, only: [:new, :create]

  def index
    #QuestionIndex is a view defined in db/views
    @questions    = QuestionIndex.paginate(per_page: 5, page: params[:page]).includes(:user)
    @universities = University.joins(:questions).distinct
  end

  def show
    #QuestionShow is a view defined in db/views
    @question = QuestionShow.find(params[:id])
    @comments = @question.comments.includes(:user).order('id ASC')
    @answers  = @question.answer_shows.includes(:user, {comments: :user}).order('id ASC')
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    #courses are unique, find existing or create new one
   course = Course.where(
      name: params[:course_name].upcase.strip.gsub(/ +/,""),
      university_domain: params[:university_domain],
   ).first_or_create

    @question      = course.questions.new(question_params)
    @question.user = current_user

    #convert markdown to html and store it in question_html_boy table
    html_body = MarkdownConverter.to_html(@question.body)

    question_html_body = @question.build_question_html_body
    question_html_body.body = html_body

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully published.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    html_body = MarkdownConverter.to_html(question_params[:body])
    respond_to do |format|
      if @question.update(question_params)
        @question.question_html_body.update(body: html_body)
        format.html { redirect_to @question, notice: "Question successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @question.destroy
        format.html { redirect_to authenticated_root_path, notice: 'Questions was deleted.' }
      else
        format.html {
          flash[:alert] = 'Answered questions cannot be deleted.'
          render :show
        }
      end
    end
  end

  def show_from_course
    @course     = Course.find(params[:course])
    @university = @course.university
    @questions  = @course.question_indices.paginate(per_page: 5, page: params[:page]).includes(:user)
    render :show_with_course
  end

  def show_from_my_university
    @university = current_user.university
    @questions  = @university.question_indices.paginate(per_page: 5, page: params[:page]).includes(:user)
    @courses    = Course.joins(:questions).where(university_domain: @university.domain).distinct
    render :show_from_university
  end

  def show_from_university
   @university   = University.find(params[:university])
   @courses      = Course.joins(:questions).where(university_domain: @university.domain).distinct
   @questions    = @university.question_indices.paginate(per_page: 5, page: params[:page]).includes(:user)
  end

  private

    def question_params
      params.require(:question).permit(:title, :body)
    end

    def set_question
      @question = Question.find(params[:id])
    end

    def set_autocomplete
      @university = current_user.university
      @courses = @university.courses.pluck(:name)
    end

    def authorize
      unless @question.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's question."
        redirect_to @question
      end
    end

end
