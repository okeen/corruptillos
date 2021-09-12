class CorruptionCase < ApplicationRecord
  enum sentence: [:pending, :innocent, :non_guilty, :guilty]

  belongs_to :user, required: false

  validates :name, :stolen_amount, :place,
            presence: true
  validates :stolen_amount, numericality: { only_integer: true, greater_than: 0 }
  validates :name, uniqueness: true

  before_save :set_slug

  scope :for_day, lambda { |day|
    day ||= Date.today
    where(created_at: [day.beginning_of_day .. day.end_of_day])
  }

  def to_param
    return nil unless persisted?
    slug
  end

  protected
    def set_slug
      self.slug = name.parameterize
    end
end
