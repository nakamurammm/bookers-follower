class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  attachment :profile_image, destroy: false

  has_many :follower, class_name: "Relationship",foreign_key: "follower_id",dependent: :destroy # フォローしている
  has_many :followed, class_name: "Relationship",foreign_key: "followed_id",dependent: :destroy # フォローされている
  has_many :follower_user, through: :followed, source: :follower #フォローしている人
  has_many :following_user, through: :follower, source: :followed #フォローされている人

  validates :name, uniqueness: true, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}


   def follow(user_id) #フォローする
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id) #フォローを外す
    relationship = self.follower.find_by(followed_id: user_id)
    relationship.destroy if relationship
  end

  def following?(user) #すでにフォローしているかの確認
    following_user.include?(user)
  end
end
