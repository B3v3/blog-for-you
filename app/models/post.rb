class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true,  length: { minimum: 6,
                                                                 maximum: 120 }
  validates :content, presence: true, length: {minimum: 11, maximum: 1000}
end
