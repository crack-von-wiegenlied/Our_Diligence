class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :users, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  #フォローした/されたの関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  #フォロー一覧画面取得用
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower


  validates :name, presence: true
  validates :name, length: { minimum: 2, maximum: 10 }
  validates :introduction, length: { maximum: 200 }

  #プロフィール画像
  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width,height]).processed
  end

  def self.guest
    find_or_create_by!(name: 'guestuser', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end


  #フォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォロー外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしているか確認する
  def following?(user)
    followings.include?(user)
  end

  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where(["name like? OR introduction like?", "#{word}", "#{word}"])
    elsif search == "forward_match"
      @user = User.where(["name like? OR introduction like?", "#{word}%", "#{word}%"])
    elsif search == "backward_match"
      @user = User.where(["name like? OR introduction like?", "%#{word}", "%#{word}"])
    elsif search == "partial_match"
      @user = User.where(["name like? OR introduction like?", "%#{word}%", "%#{word}%"])
    else
      @user = User.all
    end
  end

end
