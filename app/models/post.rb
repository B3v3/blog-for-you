class Post < ApplicationRecord
  belongs_to :user


  has_many :likes, dependent: :destroy
  has_many :users, through: :likes

  has_many :comments, dependent: :destroy


  validates :title, presence: true, uniqueness: true,  length: { minimum: 6,
                                                                 maximum: 120 }
  validates :content, presence: true, length: {minimum: 11, maximum: 20000}


  def is_liked_by?(user)
    self.users.include?(user)
  end
end
