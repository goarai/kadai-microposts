class Micropost < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255 }
  
  belongs_to :user
  
  # Favoriteに関する内容
  has_many :favorites
  has_many :liked, through: :favorites, source: :user  # model.liked でお気に入りしたユーザ一覧を取得
end
