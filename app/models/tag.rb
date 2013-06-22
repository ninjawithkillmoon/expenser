class Tag < ActiveRecord::Base
  attr_accessible :label_class, :name, :transaction_ids

  has_and_belongs_to_many :transactions

  validates(:name, {
      presence: true,
    }
  )
end
