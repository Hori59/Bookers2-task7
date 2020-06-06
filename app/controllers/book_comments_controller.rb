class BookCommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
    @book_show = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book_show.id
    @book_comment.save
    # redirect_to book_path(@book_show)
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    # redirect_to book_path(@comment.book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    comment = BookComment.find(params[:book_id])
    if current_user.id != comment.user_id
      redirect_to book_path(@book_c)
    end
  end
end
