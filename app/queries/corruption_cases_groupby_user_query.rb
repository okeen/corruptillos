class CorruptionCasesGroupbyUserQuery
  attr_reader :relation

  def self.call(relation = CorruptionCase)
    new(relation).call
  end

  def initialize(relation = CorruptionCase)
    @relation = relation
  end

  def call
    inned_joined_and_ordered_by_user
  end

  def inned_joined_and_ordered_by_user
    relation.joins(:user).order(user_id: :desc, stolen_amount: :desc)
  end
end