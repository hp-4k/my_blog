class Subscriber < ActiveRecord::Base
  before_create :generate_unsubscribe_token
  
  belongs_to :user
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    uniqueness: { scope: :user_id,
                  message: 'is already subscribed to this user',
                  case_sensitive: false },
    format: { with: VALID_EMAIL_REGEX }
  
  private
  
    def generate_unsubscribe_token
      self.unsubscribe_token = SecureRandom.urlsafe_base64
    end
  
end
