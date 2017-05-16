class GroupsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :show_from_my_university]
  before_action :set_group, only: [:show, :edit, :update]
  before_action :authorize, only: [:edit, :update]
  before_action :check_if_cancelled, only: [:edit, :update]
  before_action :set_autocomplete, only: [:new, :edit, :create, :update, :set_university_autocomplete]

  def index
    @groups = Group.paginate(per_page: 10, page: params[:page]).includes(:group_tags, :users, :creator)
    @universities = GroupTag.all_universities
  end

  def show
    @attendees = @group.users
    @comments = @group.comments.includes(:user).order('id ASC')
  end

  def new
    @group = Group.new
    @group.group_tags.build
  end

  def edit
  end

  def create
    @group = current_user.created_groups.build(group_params)
    respond_to do |format|
      if @group.save
        GroupEnrollment.create(user_id: current_user.id, group_id: @group.id) #creator is attending the group (enrolled)
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

  #used to retrieve tags in javascript via ajax when the user changes the university in the dropdown
  def set_university_autocomplete
    render json: @group_tags
  end

  def show_with_tag
    @tag = GroupTag.find(params[:tag_id])
    @groups_with_tag = @tag.groups.paginate(per_page: 10, page: params[:page]).includes(:group_tags, :users, :creator)
    render :show_with_tag
  end

  def show_from_my_university
    @university = current_user.university
    @groups_from_university = Group.tagged_with_university(@university).paginate(per_page: 10, page: params[:page]).includes(:group_tags, :users, :creator)
    @tags = GroupTag.with_university @university
    render :show_from_university
  end

  def show_from_university
    @university = params[:university]
    @groups_from_university = Group.tagged_with_university(@university).paginate(per_page: 10, page: params[:page]).includes(:group_tags, :users, :creator)
    @tags = GroupTag.with_university @university
  end

  private

  def set_autocomplete
    @university = params[:university] || @group && @group.tag_university || current_user.university
    @group_tags = GroupTag.names_with(@university)
  end

  def group_params
    params.require(:group).permit(:seats, :location, :date, :start_time, :tag_name, :tag_university, :title, :description)
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
    if @group.cancelled?
      flash[:alert] = "You are not allowed to edit cancelled groups"
      redirect_to @group
    end
  end
  
end
