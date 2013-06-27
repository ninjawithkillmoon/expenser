module TransactionsHelper
  def expenses_between(start_date, end_date)
    transactions = Transaction.where(date: start_date..end_date)
                              .where('balance < ?', 0)
  end
end