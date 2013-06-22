class Transfer
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :account_from_id, :account_to_id, :amount_dollars, :description, :date

  validates_presence_of :description, :date, :amount_dollars, :account_from_id, :account_to_id

  validate :account_from_must_exist, :account_to_must_exist, :account_from_must_not_equal_account_to

  validate :transactions_must_create

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end unless attributes.nil?
  end

  # not persisted to a database table
  def persisted?
    false
  end

  # validators

  def account_from_must_exist
    if Account.find(account_from_id).nil?
      errors.add :account_from_id, 'Invalid account from ID'
    end
  end

  def account_to_must_exist
    if Account.find(account_to_id).nil?
      errors.add :account_to_id, 'Invalid account to ID'
    end
  end

  def account_from_must_not_equal_account_to
    if account_from_id == account_to_id
      errors.add :account_from_id, 'must be different to Account to'
      errors.add :account_to_id, 'must be different to Account from'
    end
  end

  def transactions_must_create
    unless create_transactions
      errors.add :base, 'Failed to create underlying transactions'
      
      @from.errors.full_messages.each do |msg|
        errors.add :base, msg
      end

      @from.errors.full_messages.each do |msg|
        errors.add :base, msg
      end
    end
  end

  def create_transactions
    @from = Transaction.new
    @to   = Transaction.new

    @from.income = false
    @to.income   = true

    @from.description = description
    @to.description   = description

    @from.amount_dollars = amount_dollars
    @to.amount_dollars   = amount_dollars

    @from.date = date
    @to.date   = date

    @from.account_id = account_from_id
    @to.account_id   = account_to_id

    @from.tag_ids = [User.first.transfer_tag_id]
    @to.tag_ids = [User.first.transfer_tag_id]

    unless @from.save
      return false
    end
    
    unless @to.save
      return false
    end

    @to.transaction_transfer_id   = @from.id

    unless @from.save
      return false
    end
    
    unless @to.save
      return false
    end

    return true
  end

end