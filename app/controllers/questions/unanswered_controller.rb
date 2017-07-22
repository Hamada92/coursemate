class Questions::UnansweredController < ApplicationController

  def index
    @course = Course.find(params[:course])
    @questions = QuestionIndex.where(
      num_answers: 0, 
      course_name: @course.name, 
      university_domain: @course.university_domain
    ).paginate(
      per_page: 5, 
      page: params[:page]
    ).includes(:user)

    render :index
  end

end
