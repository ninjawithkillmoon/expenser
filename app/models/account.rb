class Account < ActiveRecord::Base
  attr_accessible :name, :balance, :balance_dollars, :balance_initial, :balance_initial_dollars

  has_many :transactions

  monetize :balance,         as: :balance_dollars
  monetize :balance_initial, as: :balance_initial_dollars

  validates :name, :balance, :balance_initial, presence: {value: true}

  before_validation :calculate_balance

  def calculate_balance
    balance_new_dollars = balance_initial_dollars

    transactions.each do |t|
      if t.income?
        balance_new_dollars = balance_new_dollars + t.amount_dollars
      elsif t.expense?
        balance_new_dollars = balance_new_dollars - t.amount_dollars
      end
    end

    self.balance_dollars = balance_new_dollars
  end
end
