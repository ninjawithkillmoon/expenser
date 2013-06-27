module TransactionsHelper
  def expenses_between(start_date, end_date)
    transactions = Transaction.where(date: start_date..end_date)
                              .where('income = ?', false)
                              .includes(:tag)

    return transactions
  end

  def category_expense(transactions)
    categories = Graph::CategoryGraph.new

    transactions.each do |t|
      categories.add_transaction(t)
    end

    return categories
  end
end