class Article < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :items
  validates :name, uniqueness: true
end
