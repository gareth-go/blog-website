class Dashboard::TagsController < ApplicationController
  before_action :set_tag, only: %i[update destroy]

  before_action :authenticate_user!

  def index
    @tags = policy_scope([:dashboard, Tag]).all.order(id: :desc)
    @new_tag = Tag.new
  end

  def create
    @new_tag = Tag.new(tag_params)
    authorize [:dashboard, @new_tag]
    @new_tag.save
  end

  def update
    authorize [:dashboard, @tag]
    @tag.update(tag_params)
  end

  def destroy
    authorize [:dashboard, @tag]
    @tag.destroy
  end

  private

  def tag_params
    params.required(:tag).permit(:name)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def authenticate_admin
    user_not_authorized unless current_user.admin?
  end
end
