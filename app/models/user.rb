class User < ActiveRecord::Base
  has_secure_password
  
  # name validations
  validates :name, presence: true, length: { minimum: 4 }, uniqueness: true
  
  # email validations
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
    format: { with: VALID_EMAIL_REGEX }
    
  # password validations
  validates :password, length: { minimum: 6 }, allow_nil: true
  
end
