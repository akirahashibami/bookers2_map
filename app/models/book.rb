class Book < ApplicationRecord

	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	belongs_to :user
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	def favorited_by?(user)
	  favorites.where(user_id: user.id).exists?
	end

	def Book.search(word,how_method)
		if how_method == "forward_match"
			Book.where("title LIKE ?","#{word}%")
		elsif how_method == "backward_match"
			Book.where("title LIKE ?","%#{word}")
		elsif how_method == "perfect_match"
			Book.where("title LIKE ?","#{word}")
		elsif how_method == "partial_match"
			Book.where("title LIKE ?","%#{word}%")
		else
			Book.all
		end
	end

end
