class User < ApplicationRecord
  has_many :owned_posts, foreign_key: :owner_id, class_name: "Post", dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :nickname, uniqueness: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20])
      user
  end
end
