module Graph::Bar
  class Bar < Graph::Graph
    attr_reader :data, :categories

    def initialize(is_categories=false)
      @data = {} # hash of x value to y value
      @categories = is_categories
    end

    def categories?
      @categories == true
    end

    def add_value(x, y)
      if @data[x].nil?
        @data[x] = BarDatum.new(x, 0.0)
      end

      @data[x].y = @data[x].y + y
    end

    def sort_by_month
      @data = @data.sort_by { |month_name, amount| Date::MONTHNAMES.index(month_name) }
    end

    def sort_by_month_number
      @data = @data.sort_by { |month_number, amount| month_number }
    end
  end
end