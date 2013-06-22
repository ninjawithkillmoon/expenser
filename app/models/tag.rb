class Tag < ActiveRecord::Base
  attr_accessible :label_class, :name, :transaction_ids

  has_and_belongs_to_many :transactions

  validates(:name, {
      presence: true,
    }
  )

  before_destroy :must_not_be_users_transfer_tag

  def must_not_be_users_transfer_tag
    if User.first.transfer_tag_id == id
      errors.add(:base, "Tag is the default tag for transfers")
      return false
    end
  end
end
