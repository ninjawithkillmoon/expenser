module TransactionsHelper
  def transactions_between(start_date, end_date, income=false)
    transactions = Transaction.where(date: start_date..end_date)
                              .where('income = ?', income)
                              .includes(:tag)

    return transactions
  end

  def expenses_between(start_date, end_date)
    return transactions_between start_date, end_date, false
  end

  def incomes_between(start_date, end_date)
    return transactions_between start_date, end_date, true
  end

  def category_expense(transactions)
    categories = Graph::CategoryGraph.new

    transactions.each do |t|
      categories.add_transaction(t)
    end

    return categories
  end
end