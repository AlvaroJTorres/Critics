class Game < ApplicationRecord
  belongs_to :parent, class_name: 'Game', optional: true
  has_many :expansions, class_name: 'Game',
                        foreign_key: 'parent_id',
                        dependent: :nullify,
                        inverse_of: 'parent'
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :platforms
  has_many :involved_companies, dependent: :destroy
  has_many :companies, through: :involved_companies
  has_many :critics, as: :criticable, dependent: :destroy
  has_one_attached :cover

  validates :name, :category, :cover, presence: true
  validates :name, uniqueness: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  enum category: { main_game: 0, expansion: 1 }

  validates :parent, inclusion: { in: proc { Game.main_game }, message: 'is not a valid game' },
                     if: proc { expansion? }

  validates :parent, absence: true, if: proc { main_game? }

  def developers
    # involved_companies.where(developer: true).map{ |involved_company| involved_company.company }
    involved_companies.where(developer: true).map(&:company)
  end

  def publishers
    involved_companies.where(publisher: true).map(&:company)
  end

  def approved_critics_count
    critics.where(approved: true).count
  end
end
