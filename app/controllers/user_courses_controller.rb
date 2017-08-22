class UserCoursesController < ApplicationController
  before_action :authenticate_user!

  def create
    #courses are unique
    course = Course.where(
      name: params[:course_name].upcase.strip.gsub(/ +/,""),
      university_domain: current_user.university_domain,
    ).first_or_create!

    @user_course = UserCourse.new(user_id: current_user.id, 
      course_name: course.name, 
      university_domain: current_user.university_domain
    )

    respond_to do |format|
      if @user_course.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    @user_course = UserCourse.find_by(
      user_id: current_user.id, 
      course_name: params[:id], 
      university_domain: current_user.university_domain
    )

    @user_course.destroy
    respond_to do |format|
      format.js
    end
  end
end
