class BookCommentsController < ApplicationController

  def create
    @book_show = Book.find(params[:book_id])
    @book_comment = @book_show.book_comments.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.save
    @book_comments = @book_show.book_comments
    # redirect_to book_path(@book_show)
  end

  def destroy
    @book_comment = BookComment.find(params[:id])
    @book_comment.destroy
    @book_comments = @book_comment.book.book_comments
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
