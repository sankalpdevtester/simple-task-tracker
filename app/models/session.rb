class Session < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :token, presence: true, uniqueness: true

  def self.generate_token
    SecureRandom.uuid
  end

  def self.find_by_token(token)
    find_by(token: token)
  end
end