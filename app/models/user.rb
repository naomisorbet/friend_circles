class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :session_token, :password
  validates :email, :password_digest, :presence => true
  validates :email, :uniqueness => true
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.generate_token
    SecureRandom::urlsafe_base64(32)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_token
    self.save!
  end
  
  def send_password_reset
    self.password_reset_token = self.class.generate_token
    self.password_reset_sent_at = Time.zone.now
    
    self.save!
    UserMailer.password_reset(self).deliver
  end
end
