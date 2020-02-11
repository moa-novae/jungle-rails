class User < ActiveRecord::Base
  def self.authenticate_with_credentials(email, password)
    clean_email = email.strip.downcase
    User.where('lower(email) = ?', clean_email).take.try(:authenticate, password)
  end

  has_secure_password
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false}
  validates :password, presence: true
  validates :password_confirmation, presence: true 
  validates :password, length: { minimum: 4 }
end