class CourseAutoCompletesController < ApplicationController
  before_action :find_courses, only: [:index]

  def index
    render json: @courses
  end

  private

  def find_courses
    @courses = Course.where(university_domain: params[:domain]).pluck(:name)
  end
end
