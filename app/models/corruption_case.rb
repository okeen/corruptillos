class CorruptionCase < ApplicationRecord
  enum sentence: [:pending, :innocent, :non_guilty, :guilty]
  validates :name, :stolen_amount, :place,
            presence: true
  validates :stolen_amount, numericality: { only_integer: true, greater_than: 0 }
  validates :name, uniqueness: true

  before_save :set_slug

  def to_param
    return nil unless persisted?
    slug
  end

  protected
    def set_slug
      self.slug = name.parameterize
    end
end
