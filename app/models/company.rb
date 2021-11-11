class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :cover, presence: true

  has_one_attached :cover
  has_many :involved_companies, dependent: :destroy
  has_many :games, through: :involved_companies
  has_many :critics, as: :criticable, dependent: :destroy

  def approved_critics_count
    critics.where(approved: true).count
  end
end
