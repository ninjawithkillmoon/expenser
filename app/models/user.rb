# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :transfer_tag_id

  has_secure_password

  before_save{ |user| user.email = email.downcase }
  before_save :create_remember_token

  belongs_to :transfer_tag, class_name: 'Tag', foreign_key: 'transfer_tag_id'

  validates(:name, {
      presence: true,
      length: {maximum: 50}
    }
  )

  validates(:email, {
      presence: true,
      format: {with: VALID_EMAIL_REGEX},
      uniqueness: {case_sensitive: false}
    }
  )

  validates(:password, {
      length: {minimum: 6}
    }
  )

  validates(:password_confirmation, {
      presence: true,
    }
  )

  validate :transfer_tag, presence: :true

  def first_name
    name[/(\S+)/, 1]
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
