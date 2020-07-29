class Post < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many_attached :photos
  validates :title, :rich_body, presence: true
  has_rich_text :rich_body
  has_many :reviews, dependent: :destroy
  belongs_to :category
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  STATUSES = ["drafted", "completed"]
  validates :status, inclusion: {in: STATUSES}
end
