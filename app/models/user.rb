class User < ApplicationRecord
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

  has_many :posts, dependent: :destroy
end
