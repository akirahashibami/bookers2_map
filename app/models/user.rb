class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy


  # ひょろわ〜機能
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  # フォロー取得 一行目は、ユーザーとフォローする人を結びつけています。
  # フォロワー取得 二行目は、ユーザーとフォローされる人を結びつけています。

  # 3行目 ユーザーは多くのフォローしているユーザーがいて、自分はfollower、相手はfollowed
  # 4行目 ユーザーは多くのフォローされているユーザーがいて、自分はfollowed、相手はfollower
  # follower n<--->1 User 1<-->n followed

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end
  # フォローしていればtureを返す
  def following?(user)
    following_user.include?(user)
  end


  def User.search(word,how_method)
    if how_method == "forward_match"
      User.where("name LIKE ?","#{word}%")
    elsif how_method == "backward_match"
      User.where("name LIKE ?","%#{word}")
    elsif how_method == "perfect_match"
      User.where("name LIKE ?","#{word}")
    elsif how_method == "partial_match"
      User.where("name LIKE ?","%#{word}%")
    else
      @search = User.all
    end
  end

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, uniqueness: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }


end
