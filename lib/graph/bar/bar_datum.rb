module Graph::Bar
  class BarDatum
    attr_accessor :x, :y

    def initialize(x, y)
      @x = x
      @y = y
    end
  end
end