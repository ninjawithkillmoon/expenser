class Transaction < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper, ActionView::Helpers::TranslationHelper

  attr_accessible :amount, :amount_dollars, :date, :description, :income,
                  :account_id, :contact_id, :transaction_settlement_id, :transaction_transfer_id, :tag_id

  belongs_to :account
  belongs_to :paid_on_behalf,        class_name: 'Contact',     foreign_key: 'contact_id'
  belongs_to :settles,               class_name: 'Transaction', foreign_key: 'transaction_settlement_id'
  belongs_to :corresponding_expense, class_name: 'Transaction', foreign_key: 'transaction_transfer_id', dependent: :destroy
  belongs_to :tag

  has_one :corresponding_income, class_name: 'Transaction', foreign_key: 'transaction_transfer_id'

  has_many :settled_by, class_name: 'Transaction', foreign_key: 'transaction_settlement_id'

  monetize :amount, as: :amount_dollars

  validates :description, :date, :amount, :account, :tag, presence: {value: :true, message: 'cannot be blank'}

  validates :income, inclusion: {in: [true, false]}

  validates :income, inclusion: {in: [false], message: 'must be EXPENSE when a contact to pay on behalf of is selected'}, if: :paid_on_behalf?

  validates :income, inclusion: {in: [true], message: 'must be INCOME when a settlement transaction is selected'}, if: :settles?

  validate :transaction_must_have_contact, if: :settles?

  validate :corresponding_must_be_expense, :corresponding_must_link, if: :transfer_to?

  validate :corresponding_must_be_income, :corresponding_must_link, if: :transfer_from?

  before_save :match_settles_tag

  after_save :recalculate_account_balance

  ## validation helpers
  def transaction_must_have_contact
    if settles?
      unless settles.paid_on_behalf?
        errors.add(:transaction_settlement_id, 'must have an associated contact that it was paid on behalf of')
      end
    end
  end

  def corresponding_must_be_expense
    if transfer_to?
      unless corresponding_expense.expense?
        errors.add(:transaction_transfer_id, 'must be an expense')
      end
    end
  end

  def corresponding_must_be_income
    if transfer_from?
      unless corresponding_income.income?
        errors.add(:transaction_transfer_id, 'must be an income')
      end
    end
  end

  def corresponding_must_link
    if transfer_to?
      unless corresponding_expense.corresponding_income.id == id
        errors.add(:transaction_transfer_id, 'must be linked to this transaction')
      end
    elsif transfer_from?
      unless corresponding_income.corresponding_expense.id == id
        errors.add(:transaction_transfer_id, 'must be linked to this transaction')
      end
    end
  end

  ## callbacks
  def recalculate_account_balance
    account.calculate_balance
    account.save!
  end

  def match_settles_tag
    if settles?
      tag = settles.tag
    end
  end

  ## helpers

  def expense?
    return !income?
  end

  def transfer?
    return transfer_to? || transfer_from?
  end

  ## nil checkers

  def paid_on_behalf?
    return !paid_on_behalf.nil?
  end

  def settles?
    return !settles.nil?
  end

  def settled?
    return !settled_by.nil?
  end

  def transfer_to?
    return !corresponding_expense.nil?
  end

  def transfer_from?
    return !corresponding_income.nil?
  end

  def account?
    return !account.nil?
  end

  ## string helpers

  def tag_html
    tag.label_html
  end

  def income_string
    if income
      return 'Income'
    else
      return 'Expense'
    end
  end

  def summary_string(options = {})
    str = ""

    if options[:format] == :short
      if income?
        str << "+"
      else
        str << "-"
      end

      str << "#{number_to_currency amount_dollars}"

      if paid_on_behalf?
        str << " / #{paid_on_behalf.name}"
      end

      if options[:include_date]
        str << " / #{l date, format: :long}"
      end
    else
      if income?
        str << "+"
      else
        str << "-"
      end

      str << "#{number_to_currency amount_dollars}"

      if paid_on_behalf?
        str << " paid on behalf of #{paid_on_behalf.name}"
      end

      if options[:include_date]
        str << " on #{l date, format: :long}"
      end
    end

    return str
  end

  def icon_html
    str = ''

    if transfer?
      str << '<i class="icon-exchange purple bigger-110"></i>'
    elsif income?
      str << '<i class="icon-plus green bigger-110"></i>'
    elsif expense?
      str << '<i class="icon-minus red bigger-110"></i>'
    end

    return str.html_safe
  end
end
