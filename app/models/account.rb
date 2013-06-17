class Account < ActiveRecord::Base
  attr_accessible :balance, :name

  monetize :balance, as: :balance_dollars

  validates(:name, {
      presence: true,
    }
  )
end
