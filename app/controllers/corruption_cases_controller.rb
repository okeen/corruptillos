class CorruptionCasesController < ApplicationController
  def new
    @corruption_case = collection.new
  end

  def create
    @corruption_case = collection.new(permitted_params)
    if @corruption_case.save
      redirect_to [:corruption_cases], notice: t(".success")
    else
      render "new"
    end
  end

  protected

  def collection
    CorruptionCase.all
  end

  def permitted_params
    params.require(:corruption_case).permit(:name, :description, :stolen_amount, :place, :trial_start_at,
                                            :sentenced_at, :sentence, :european_funds_project)
  end
end
