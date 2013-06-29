class JavascriptsController < ApplicationController
  include TransactionsHelper

  before_filter :signed_in_user

  def expense_report_data
    @pie = Graph::Pie::Pie.new
    transactions = expenses_between 28.days.ago, DateTime.now

    transactions.each do |t|
      @pie.add_value t.tag.name, t.amount
    end

    @pie.sort_by_value
  end
end