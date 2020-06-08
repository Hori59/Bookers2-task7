class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #能動的関係をとおしてフォローしているユーザーを取得する
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  #フォローされているユーザーを取得する
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed #フォロー
  has_many :followers, through: :passive_relationships, source: :follower #フォロワー
  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {in: 2..20}
  validates :email, {uniqueness: true}
  validates :introduction, length: {maximum: 50}

#フォロー機能
  def follow(other_user) #ユーザーをフォローする
    following << other_user
  end

  def unfollow(other_user) #ユーザーをフォロー解除する
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user) #現在のユーザーがフォローしてたらtrueを返す
    following.include?(other_user)
  end

#ユーザー検索機能
  def User.search(search_word, user_or_book, how_search)
    if user_or_book == "1"
      if how_search == "perfect_match"
        @users = User.where('name LIKE ?',"#{search_word}")
      elsif how_search == "forward_match"
        @users = User.where('name LIKE ?', "#{search_word}%")
      elsif how_search == "backward_match"
        @users = User.where('name LIKE ?', "%#{search_word}")
      elsif how_search == "partial_match"
        @users = User.where('name LIKE ?', "%#{search_word}%")
      else
        @users = User.all
      end
    end
  end

  #prefecture_codeからprefecture_nameに変換するメソッド
  include JpPrefecture
 jp_prefecture :prefecture_code

 def prefecture_name
     JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
 end

 def prefecture_name=(prefecture_name)
     self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
 end
end
