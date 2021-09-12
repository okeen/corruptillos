class User::MyCorruptionCasesController < User::BaseController
  def new
    @corruption_case = collection.new
  end

  def create
    @corruption_case = collection.new(permitted_params)
    if @corruption_case.save
      redirect_to after_action_path, notice: t(".success")
    else
      flash.now[:error] = t('.failure')
      render "new"
    end
  end

  def index
    @corruption_cases = collection.all
  end

  def edit
    @corruption_case = collection.find_by(slug: params[:slug])
  end

  def update
    @corruption_case = collection.find_by(slug: params[:slug])
    if @corruption_case.update(permitted_params)
      redirect_to after_action_path, notice: t(".success")
    else
      flash.now[:error] = t('.failure')
      render "edit"
    end
  end

  def destroy
    @corruption_case = collection.find_by(slug: params[:slug])
    if @corruption_case.destroy
      redirect_to after_action_path, notice: t(".success")
    else
      redirect_to after_action_path, error: t(".failure")
    end
  end

  protected

  def collection
    current_user.corruption_cases.all
  end

  def permitted_params
    params.require(:corruption_case).permit(:name, :description, :stolen_amount, :place, :trial_start_at,
                                            :sentenced_at, :sentence, :european_funds_project)
  end

  def after_action_path
    [:user, :corruption_cases]
  end
end
