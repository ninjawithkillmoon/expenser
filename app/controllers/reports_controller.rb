class ReportsController < ApplicationController
  include TransactionsHelper

  before_filter :signed_in_user

  add_breadcrumb "Reports", '/reports'

  def expense
    process_dates
    fetch_transactions

    add_breadcrumb "Expense", '/reports/expense'

    @permitted_params = ['date_start', 'date_end']
  end

  private #---------------------------------------

  def fetch_transactions
    @transactions = expenses_between params[:date_start], params[:date_end]
  end

  def process_dates
    unless params[:nav].nil?
      case params[:nav]
      when 'month'
        params[:date_start] = Date.today.beginning_of_month
        params[:date_end]   = Date.today.end_of_month
      when 'month_last'
        params[:date_start] = Date.today.ago(1.month).beginning_of_month
        params[:date_end]   = Date.today.ago(1.month).end_of_month
      when 'month_last_3'
        params[:date_start] = Date.today.ago(2.month).beginning_of_month
        params[:date_end]   = Date.today.end_of_month
      when 'year'
        params[:date_start] = Date.today.beginning_of_year
        params[:date_end]   = Date.today.end_of_year
      when 'year_last'
        params[:date_start] = Date.today.ago(1.year).beginning_of_year
        params[:date_end]   = Date.today.ago(1.year).end_of_year
      when 'custom'

      else

      end
    end
  end
end