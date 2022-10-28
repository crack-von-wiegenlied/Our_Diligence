class Category < ApplicationRecord

  has_many :posts, dependent: :destroy
  validates :name, presence: true
  validates :name, length: { maximum: 15 }

end
