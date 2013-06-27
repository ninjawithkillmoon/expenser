class StaticPagesController < ApplicationController
  include TransactionsHelper

  before_filter :signed_in_user

  def home
    @accounts = Account.all
    @contacts = Contact.all

    make_balance_data
    make_loan_data
    make_expense_data
  end

  private #-----------------------------------------------------------

  def make_balance_data
    @totalBalance = Money.new(0)
    @biggestPositive = Money.new(0)
    @biggestNegative = Money.new(0)

    @accounts.each do |account|
      @totalBalance = @totalBalance + account.balance_dollars
      
      if account.balance_dollars > @biggestPositive
        @biggestPositive = account.balance_dollars
      end

      if account.balance_dollars < @biggestNegative
        @biggestNegative = account.balance_dollars
      end
    end
  end

  def make_loan_data
    @totalBalanceLoan = Money.new(0)
    @biggestPositiveLoan = Money.new(0)
    @biggestNegativeLoad = Money.new(0)

    @contacts.each do |contact|
      @totalBalanceLoan = @totalBalanceLoan + contact.balance_dollars
      
      if contact.balance_dollars > @biggestPositiveLoan
        @biggestPositiveLoan = contact.balance_dollars
      end

      if contact.balance_dollars < @biggestNegativeLoad
        @biggestNegativeLoad = contact.balance_dollars
      end
    end
  end

  def make_expense_data
    now = DateTime.now
    before = 28.days.ago

    @expenses = expenses_between(before, now)

    @grapher = category_expense @expenses
    @grapher.sort_by_amount

    @colours = ['#68BC31', '#2091CF', '#AF4E96', '#DA5430', '#FEE074'];
  end
end
