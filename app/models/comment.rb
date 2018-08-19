class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: {minimum: 2, maximum: 500}
  validates :user_id, presence: true
  validates :post_id, presence: true
  
end
