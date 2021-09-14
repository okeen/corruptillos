class DailyCorruptionReportsController < ApplicationController
  helper :corruption_cases

  def show
    @daily_corruption_report = collection.find(params[:id])
    @corruption_cases = CorruptionCasesGroupbyUserQuery.new(
      @daily_corruption_report.corruption_cases
    ).inned_joined_and_ordered_by_user
  end

  def index
    @daily_corruption_reports = collection
  end

  protected

  def collection
    DailyCorruptionReport.all
  end
end
