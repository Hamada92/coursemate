class Questions::UnansweredController < ApplicationController

  def index
    @course = Course.find(params[:course])
    @questions = @course.question_indices.unanswered.paginate(per_page: 5, page: params[:page]).includes(:user)
    render :index
  end

end
