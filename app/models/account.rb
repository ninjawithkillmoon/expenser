class Account < ActiveRecord::Base
  attr_accessible :balance, :name, :balance_dollars

  monetize :balance, as: :balance_dollars

  validates(:name, {
      presence: true,
    }
  )
end
