class TagUser < ApplicationRecord
  belongs_to :user_id
  belongs_to :tag_id
end
