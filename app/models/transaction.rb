class Transaction < ActiveRecord::Base
  attr_accessible :amount, :amount_dollars, :date, :description, :income

  monetize :amount, as: :amount_dollars

  validates(:description, {
      presence: true,
    }
  )

  validates(:income, {
      inclusion: {in: [true, false]},
    }
  )

  validates(:date, {
      presence: true,
    }
  )

  validates(:amount, {
      presence: true,
    }
  )

  def tags_html
    return "<span class='label label-large label-pink arrowed-right'>test label 1</span><span class='label label-large label-info arrowed-in-right arrowed'>test label 2</span>".html_safe
  end

  def income_string
    if income
      return 'Income'
    else
      return 'Expense'
    end
  end

  # placeholder!!
  def account
    return 'Example Account'
  end
end
