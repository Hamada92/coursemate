class CoursesController < ApplicationController

  def find_or_create  
    university = University.find(params[:university_domain])
    @course = university.courses.create(course_params)
    respond_to do |format|
      format.js
    end
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
