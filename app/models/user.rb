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


  def follow(other_user) #ユーザーをフォローする
    following << other_user
  end

  def unfollow(other_user) #ユーザーをフォロー解除する
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user) #現在のユーザーがフォローしてたらtrueを返す
    following.include?(other_user)
  end

end
