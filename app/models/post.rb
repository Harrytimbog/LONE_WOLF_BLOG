class Post < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many_attached :photos
  validates :title, :rich_body, presence: true
  has_rich_text :rich_body
  has_many :post_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :category

  STATUSES = ["drafted", "published"]
  validates :status, inclusion: {in: STATUSES}
end
