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
         :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first
    user ||= User.create!(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0, 20], picture_url: auth.info.image, nickname: auth.info.nickname)
      user
  end

=begin
   def self.from_omniauth(auth)
     user_params = auth.slice("provider", "uid")
     user_params.merge! auth.info.slice("email", "nickname")
     user_params[:picture_url] = auth.info.image
     user_params[:token] = auth.credentials.token
     #user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
     user_params = user_params.to_h

     user = User.find_by(provider: auth.provider, uid: auth.uid)
     user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
     if user
       user.update(user_params)
     else
       user = User.new(user_params)
       user.password = Devise.friendly_token[0,20]  # Fake password for validation
       user.save
     end

     return user
   end
=end
end
