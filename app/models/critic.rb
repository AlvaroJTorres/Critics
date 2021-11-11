class Critic < ApplicationRecord
  belongs_to :user
  belongs_to :criticable, polymorphic: true

  validates :title, :body, presence: true
  validates :title, length: { maximum: 140 }
  validates :body, length: { maximum: 600 }
end
