class Comment < ApplicationRecord
  belongs_to :message
  belongs_to :user

  validates :content, presence: true, length: {minimum: 3, maximum: 300}

end
