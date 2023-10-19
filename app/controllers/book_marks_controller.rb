class BookMarksController < ApplicationController
  def create
    unless user_signed_in?
      flash.now[:alert] = 'You need to signin before save a post.'
      return
    end

    @book_mark = BookMark.create(user: current_user, post_id: params[:post_id])
  end

  def destroy
    @book_mark = BookMark.destroy(params[:id])
  end
end
