class BookMarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @book_mark = BookMark.create(user: current_user, post_id: params[:post_id])
  end

  def destroy
    @book_mark = BookMark.destroy(params[:id])
  end
end
