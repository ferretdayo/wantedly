class TaggerUser < ApplicationRecord
  belongs_to :tag_user
  belongs_to :user
end
