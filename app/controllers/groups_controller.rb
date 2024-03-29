class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :show_from_my_university]
  before_action :set_group, only: [:edit, :update]
  before_action :authorize, only: [:edit, :update]
  before_action :check_if_cancelled, only: [:edit, :update]
  before_action :set_autocomplete, only: [:new, :create]

  def index
    #GroupIndex is a SQL view, defined in db/views
    @groups = GroupIndex.paginate(per_page: 5, page: params[:page]).includes(:creator)
    @universities = University.universities_that_have_groups
  end

  def show
    @group = GroupShow.find(params[:id])
    @attendees = User.where(id: @group.attendees)
    @comments = @group.comments.includes(:user).order('id ASC')
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    #courses are unique
    course = Course.where(
      name: params[:course_name].upcase.strip.gsub(/ +/,""),
      university_domain: params[:university_domain],
    ).first_or_create

    @group = course.groups.new(group_params)
    @group.creator = current_user
    @group.status = 'active'
    
    respond_to do |format|
      if @group.save
        #enroll the creator in the group 
        GroupEnrollment.create!(user: current_user, group: @group)
        format.html { redirect_to @group, notice: 'Group was successfully published.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "Group successfully updated." }
      else
        format.html { render :edit }
      end
    end
  end

  def show_from_course
    @course = Course.find(params[:course])
    @university = @course.university
    @groups = @course.group_indices.paginate(per_page: 5, page: params[:page]).includes(:creator)
    render :show_with_course
  end

  def show_from_my_university
    @university = current_user.university
    @groups = @university.group_indices.paginate(per_page: 5, page: params[:page]).includes(:creator)
    @courses = Course.joins(:groups).where(university_domain: @university.domain).distinct
    render :show_from_university
  end

  def show_from_university
    @university = University.find(params[:university])
    @courses = Course.joins(:groups).where(university_domain: @university.domain).distinct
    @groups = @university.group_indices.paginate(per_page: 5, page: params[:page]).includes(:creator)
  end

  private

    def set_autocomplete
      @university = current_user.university
      @courses    = @university.courses.pluck(:name)
    end

    def group_params
      params.require(:group).permit(:seats, :location, :starts_at, :ends_at, :title, :description)
    end

    def set_group
      @group = Group.find(params[:id])
    end

    def authorize
      unless @group.creator_id == current_user.id
        flash[:alert] = "You are not allowed to edit someone else's group."
        redirect_to @group
      end
    end

    def check_if_cancelled
      unless @group.active?
        flash[:alert] = "You are not allowed to edit cancelled or completed groups"
        redirect_to @group
      end
    end
  
end
