class Post < ApplicationRecord

  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  validates :title, presence: true, uniqueness: true,  length: { minimum: 6,
                                                                 maximum: 120 }
  validates :content, presence: true, length: {minimum: 11, maximum: 10000}

  belongs_to :user

  def is_liked_by?(user)
    self.users.include?(user)
  end
end
