class Tag < ApplicationRecord
    has_many :tag_users
    has_many :users, :through => :tag_users
end
