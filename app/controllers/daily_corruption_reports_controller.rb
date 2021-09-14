class DailyCorruptionReportsController < ApplicationController
  helper :corruption_cases

  def index
    @daily_corruption_reports = collection
  end

  protected

  def collection
    DailyCorruptionReport.all
  end
end
