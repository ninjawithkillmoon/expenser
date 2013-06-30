class Contact < ActiveRecord::Base
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper
  
  attr_accessible :name

  validates(:name, {
      presence: true,
    }
  )

  # Calculates the balance owed (or owing to) this contact.
  #
  # * *Args*    :
  #   - ++ -> 
  # * *Returns* :
  #   - 
  #
  def balance_dollars
    transactions = Transaction.where('contact_id =  ?', id)
                              .includes(:settled_by)

    totalPaid = Money.new(0)
    totalSettled = Money.new(0)

    transactions.each do |loan|
      totalPaid = totalPaid + loan.amount_dollars

      loan.settled_by.each do |payback|
        totalSettled = totalSettled + payback.amount_dollars
      end
    end

    return totalPaid + totalSettled
  end

  def balance_html
    return "#{plus_minus_html balance_dollars} #{number_to_currency balance_dollars.abs}"
  end

  def positive?
    return balance_dollars >= 0.0
  end

  def negative?
    return balance_dollars < 0.0
  end
end
