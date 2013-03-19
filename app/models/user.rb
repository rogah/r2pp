# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  active          :boolean          default(FALSE)
#  last_sign_in    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted_at      :datetime
#

class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation
  
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { email.downcase! }

  validates :name, 	
  	presence: true, 
  	length: { maximum: 50 }
  
  validates :email, 
  	presence: true,
  	format: { with: EMAIL_REGEX },
  	uniqueness: { case_sensitive: false }

  validates :password, 
  	presence: true, 
  	length: { minimum: 6 }

  validates :password_confirmation, 
  	presence: true
end
