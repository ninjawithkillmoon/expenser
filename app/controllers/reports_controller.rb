class ReportsController < ApplicationController
  before_filter :signed_in_user

  add_breadcrumb "Reports", '/reports'

  def expense
    add_breadcrumb "Expense", '/reports/expense'
  end
end