class Post < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many_attached :photos
  validates :title, :rich_body, presence: true
  has_rich_text :rich_body
end
