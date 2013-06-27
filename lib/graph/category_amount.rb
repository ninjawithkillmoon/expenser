module Graph
  class CategoryAmount
    attr_accessor :tag, :amount

    def initialize(tag)
      @tag = tag
      @amount = Money.new(0)
    end

    def add(amount_dollars)
      @amount = @amount + amount_dollars
    end
  end
end