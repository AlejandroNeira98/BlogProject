class Post < ApplicationRecord
  belongs_to :user

  has_many :like
  has_many :comment
end
