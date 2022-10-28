class Post < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :work_time, presence: true
  validates :start_time, presence: true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where(["title like? OR body like?", "#{word}", "#{word}"])
    elsif search == "forward_match"
      @post = Post.where(["title like? OR body like?", "#{word}%", "#{word}%"])
    elsif search == "backward_match"
      @post = Post.where(["title like? OR body like?", "%#{word}", "%#{word}"])
    elsif search == "partial_match"
      @post = Post.where(["title like? OR body like?", "%#{word}%", "%#{word}%"])
    else
      @post = Post.all
    end
  end

end
