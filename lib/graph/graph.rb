module Graph
  class Graph
    attr_accessor :colours_index
    attr_reader :colours

    def next_colour
      if @colours.nil? || @colours.size <= 0
        @colours = ['#68BC31', '#2091CF', '#AF4E96', '#DA5430', '#FEE074', '#D6487E', '#FF8000', '#52E8FF', '#6BE879']
      end

      if @colours_index.nil?
        reset_colour
      end

      @colours_index = @colours_index + 1
      return @colours[@colours_index % @colours.size]
    end

    def reset_colour
      @colours_index = -1
    end
  end
end