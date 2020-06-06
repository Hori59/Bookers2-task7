class Book < ApplicationRecord
	belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

    #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  #presence trueは空欄の場合を意味する。
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #検索機能
  def Book.search(search_word, user_or_book, how_search)
    if user_or_book == "2"
      if how_search == "perfect_match"
        @books = Book.where('title LIKE ?', "#{search_word}")
      elsif how_search == "forward_match"
        @books = Book.where('title LIKE ?', "#{search_word}%")
      elsif how_search == "backward_match"
        @books = Book.where('title LIKE ?', "%#{search_word}")
      elsif how_search == "partial_match"
        @books = Book.where('title LIKE ?', "%#{search_word}%")
      else
        @books = Book.all
      end
    end
  end
end
