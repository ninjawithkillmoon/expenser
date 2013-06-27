module Graph
  class CategoryGraph
    attr_accessor :categories, :total

    def initialize
      @categories = {}
      @total = Money.new(0)

      Tag.all.each do |tag|
        @categories[tag.id] = CategoryAmount.new(tag)
      end
    end

    def add_transaction(transaction)
      @categories[transaction.tag_id].add(transaction.amount_dollars)

      @total = @total - transaction.amount_dollars
    end

    def sort_by_amount
      @categories = @categories.sort_by { |k, v| v.amount }.reverse
    end
  end
end