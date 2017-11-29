class Item < ApplicationRecord
  belongs_to :user
  belongs_to :transaction
  belongs_to :article
end
