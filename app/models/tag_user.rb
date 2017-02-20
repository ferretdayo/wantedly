class TagUser < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  has_many :tagger_users
  has_many :users, :through => :tagger_users
end
