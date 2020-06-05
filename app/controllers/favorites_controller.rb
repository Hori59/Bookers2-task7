class FavoritesController < ApplicationController
  before_action :set_book

  def create
    favorite = current_user.favorites.new(book_id: @book_f.id)
    favorite.save
    #redirect_to book_path(@book_f)
    #byebug
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, book_id: @book_f.id)
    favorite.destroy
    #redirect_to book_path(@book_f)
  end


  private
  def set_book
    @book_f = Book.find(params[:book_id])
  end
end
