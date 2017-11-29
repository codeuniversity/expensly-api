class Category < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :categories
  has_many :articles
  has_many :items, through: :articles
end
