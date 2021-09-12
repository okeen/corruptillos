class CorruptionCasesController < ApplicationController
  def index
    @corruption_cases = collection.all
  end

  protected

  def collection
    if (user = User.find_by(id: params[:user_id]))
      user.corruption_cases
    else
      CorruptionCase.all
    end
  end
end
