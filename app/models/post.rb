class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

end
