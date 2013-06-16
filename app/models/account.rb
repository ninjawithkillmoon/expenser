class Account < ActiveRecord::Base
  attr_accessible :balance, :name

  validates(:name, {
      presence: true,
    }
  )
end
