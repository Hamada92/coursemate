class Questions::UnansweredController < ApplicationController

  def index
    @course = Course.find(params[:course])
    @questions = QuestionIndex.unanswered(@course.name, @course.university_domain).
      paginate(
        per_page: 5, 
        page: params[:page]
      ).includes(:user)

    render :index
  end

end
