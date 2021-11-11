class InvolvedCompany < ApplicationRecord
  belongs_to :game
  belongs_to :company

  validates :company, uniqueness: { scope: :game }
  validates :developer, presence: true, unless: proc { publisher? }
  validates :publisher, presence: true, unless: proc { developer? }
end
