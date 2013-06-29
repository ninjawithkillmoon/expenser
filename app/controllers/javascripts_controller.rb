class JavascriptsController < ApplicationController
  include TransactionsHelper

  before_filter :signed_in_user

  def expense_report_data_pie
    @pie = Graph::Pie::Pie.new
    @total = Money.new(0.0)

    process_dates_pie
    fetch_transactions

    @transactions.each do |t|
      @pie.add_value t.tag.name, t.amount_dollars.amount
      @total = @total + t.amount_dollars
    end

    @pie.sort_by_value
  end

  def expense_report_data_bar
    @bar = Graph::Bar::Bar.new
    
    process_dates_bar
    fetch_transactions

    @transactions.each do |t|
      @bar.add_value Date::MONTHNAMES[t.date.month], t.amount_dollars.amount
    end

    @bar.sort_by_month
  end

  private #--------------------------------------------------

  def fetch_transactions
    @transactions = expenses_between params[:date_start], params[:date_end]
  end

  def process_dates_pie
    if params[:date_start].nil?
      params[:date_start] = Date.today.beginning_of_month
    end

    if params[:date_end].nil?
      params[:date_end] = Date.today.end_of_month
    end
  end

  def process_dates_bar
    process_dates_pie

    if params[:date_start].to_datetime > Date.today.ago(1.month).beginning_of_month
      params[:date_start] = Date.today.ago(1.month).beginning_of_month
    end

    # first adjust the end date
    if (params[:date_end].to_datetime - params[:date_start].to_datetime) < 365
      params[:date_end] = Date.today.end_of_month
    end

    # now adjust the start date
    if (params[:date_end].to_datetime - params[:date_start].to_datetime) < 365
      params[:date_start] = Date.today.ago(12.months).beginning_of_month
    end
  end
end