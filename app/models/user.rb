class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                  uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
    
  # Favoriteに関する内容
  has_many :favorites
  has_many :likes, through: :favorites, source: :micropost  # model.likes でお気に入り一覧を取得
  
  
  # followに関する操作
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  # likeに関する操作
  def like(one_micropost)
    self.favorites.find_or_create_by(micropost_id: one_micropost.id) #Favoriteテーブル全体からレコードを見つける or 作成する
  end

  def unlike(one_micropost)
    like = self.favorites.find_by(micropost_id: one_micropost.id) #Favoriteテーブルから該当のレコードを抜き出す
    like.destroy if like
  end

  def like?(one_micropost)
    self.likes.include?(one_micropost) #自分のお気に入り一覧に含まれているかどうか確認
  end
  
  # トップページのタイムラインに、自分とフォローするユーザのツイートを表示
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end

end
