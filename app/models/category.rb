class Category < ApplicationRecord
  has_many :post_categories
  has_many :posts
end
