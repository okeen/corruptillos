class CorruptionCase < ApplicationRecord
  enum sentence: [:pending, :innocent, :non_guilty, :guilty]
  validates :name, :stolen_amount, :place,
            presence: true
  validates :stolen_amount, numericality: { only_integer: true, greater_than: 0 }
end
