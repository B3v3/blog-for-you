class User < ApplicationRecord
   has_many :posts, dependent: :destroy

   has_many :active_follows,      class_name:  "Follow",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
   has_many :passive_follows,     class_name:  "Follow",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy

  has_many :following, through: :active_follows,  source: :followed
  has_many :followers, through: :passive_follows, source: :follower

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :comments, dependent: :destroy


  before_save { self.email = email.downcase }

  VALID_NAME_REGEX = /\A[a-z0-9\-_]+\z/i
  validates :nickname, presence: true, length: { minimum: 3, maximum: 25 },
                                       uniqueness: { case_sensitive: false },
                                       format: { with: VALID_NAME_REGEX }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, allow_nil: true, length: { maximum: 199 },
                                     format: { with: VALID_EMAIL_REGEX },
                                     uniqueness: { case_sensitive: false }

  validates :password, allow_nil: true, length: { minimum: 6 }
  validates :password_confirmation, allow_nil: true, length: { minimum: 6 }
  has_secure_password

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    following_ids = self.following.collect(&:id)
    Post.where(user_id: following_ids)
  end

  def notify_followers
    followers.each do |f|
      f.update_attribute(:notification_count, (f.notification_count + 1))
    end
  end

  def clear_notifications
    update_attribute(:notification_count, 0)
  end
end
