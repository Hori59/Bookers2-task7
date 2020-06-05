class BookCommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]

  def create
    @book_c = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book_c.id
    @comment.save
    redirect_to book_path(@book_c)
  end

  def destroy
    @comment = BookComment.find(params[:book_id])
    # @comment = BookComment.find_by(id: params[:id], book_id: @book_c.id)
    @comment.destroy
    # byebug
    redirect_to book_path(@comment.book)
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
