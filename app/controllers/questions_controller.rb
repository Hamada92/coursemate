class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :show_from_my_university]
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :set_autocomplete, only: [:new, :edit, :create, :update, :set_university_autocomplete]

  def index
    @questions = Question.paginate(per_page: 10, page: params[:page]).includes(:tags, :likes, :user)
    @universities = Tag.all_universities
  end

  def show
    @answers = @question.answers.includes(:user, :likes, {comments: :user}).order('num_likes DESC')
    @question_comments = @question.comments.includes(:user).order('id ASC')
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

    @question = course.questions.new(question_params)
    @question.user = current_user

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully published.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
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
    @course = Course.find(params[:course])
    @questions = @course.questions.paginate(per_page: 10, page: params[:page]).includes(:likes, :user)
    @university = @course.university
    render :show_with_course
  end

  def show_from_my_university
    @university = current_user.university
    @questions = @university.questions.paginate(per_page: 10, page: params[:page]).includes(:likes, :user)
    @courses = @university.courses.where('num_questions > 0')
    render :show_from_university
  end

  def show_from_university
    @university = University.find(params[:university])
    @courses = @university.courses.where('num_questions > 0')
    @questions = @university.questions.paginate(per_page: 10, page: params[:page]).includes(:likes, :user)
  end

  #used to retrieve tags in javascript via ajax when the user changes the university in the dropdown
  def set_university_autocomplete
    render json: @courses
  end

  private

    def question_params
      params.require(:question).permit(:title, :body)
    end

    def set_question
      @question = Question.find(params[:id])
    end

    def set_autocomplete
      @university = params[:domain] && University.find(params[:domain]) || @question && @question.university || current_user.university
      @courses = @university.courses.pluck(:name)
    end

    def authorize
      unless @question.user == current_user
        flash[:alert] = "You are not allowed to edit someone else's question."
        redirect_to @question
      end
    end

end
