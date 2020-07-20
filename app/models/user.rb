class User < ApplicationRecord
  has_many :owned_posts, foreign_key: :owner_id, class_name: "Post", dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
