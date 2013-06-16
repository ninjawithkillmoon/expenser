class Tag < ActiveRecord::Base
  attr_accessible :label_class, :name

  validates(:name, {
      presence: true,
    }
  )
end
