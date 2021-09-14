module CorruptionCasesHelper
  def table_for_corruption_cases(corruption_cases)
    table_for(corruption_cases, { partial: 'corruption_cases/corruption_case' },
              :name, :place, :stolen_amount, :trial_started_at, :sentence, :user)
  end
end
