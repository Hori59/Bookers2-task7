class SearchController < ApplicationController
  def search
    @user_or_book = params[:search_option]
    @how_search = params[:search_choice]
    if @user_or_book == "1"
      @users = User.search(params[:search_word], @user_or_book, @how_search).page(params[:page]).per(10)
    else
      @books = Book.search(params[:search_word], @user_or_book, @how_search).page(params[:page]).per(10)
    end
  end
end
