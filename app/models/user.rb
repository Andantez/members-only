# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token
  before_create :create_new_token
  has_secure_password
  has_many :posts

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def self.digest(string)
    Digest::SHA1.hexdigest(string.to_s)
  end

  def create_new_token
    self.remember_token = User.new_token
    self.remember_digest = User.digest(remember_token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
