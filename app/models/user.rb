class User < ApplicationRecord
    has_secure_password
    has_many :tag_users
    has_many :tags, :through => :tag_users

    # has_many :tagger_users
    # has_many :tag_users, :through => :tagger_users

    # accepts_nested_attributes_for :tag_users, allow_destroy: true
    
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # not null, unique
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true
end
