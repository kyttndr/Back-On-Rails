class Tag < ApplicationRecord
  has_many :item_tags
  has_many :items, through: :item_tags
  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end