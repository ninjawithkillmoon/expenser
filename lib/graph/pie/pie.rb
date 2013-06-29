module Graph::Pie
  class Pie < Graph::Graph
    attr_reader :data, :total

    def initialize
      @data = {} # hash of string (label) to PieDatum
      @total = 0.0
      reset_colour
    end

    def add_value(label, value)
      if @data[label].nil?
        @data[label] = PieDatum.new(label, 0.0, next_colour)
      end

      @data[label].value = @data[label].value + value
      @total += value
    end

    # Combines all values after the specified number
    # into a new category: 'Other'.
    #
    # After running this method, the old data is discarded
    # so use with caution.
    #
    # This is also fairly obsolete since I discovered that
    # there is an option in the jQuery flot pie for combining
    # any slices below a certain percentage.
    #
    # * *Args*    :
    #   - +num_slices+ -> The number of slices to leave in the pie (not including the 'Other' slice)
    # * *Returns* :
    #   - 
    #
    def create_other(num_slices=5)
      newData = {}
      otherValue = 0.0
      otherLabel = 'other'

      sort_by_value
      PieDatum.reset_colour

      count = 0
      @data.each do |label, datum|
        if count < num_slices
          # place the datum into the new data hash
          datum.colour = PieDatum.next_colour
          newData[label] = datum
        else
          # add the amount on to the other datum
          otherValue = otherValue + datum.value
        end

        count = count + 1
      end

      newData[otherLabel] = PieDatum.new(otherLabel, otherValue)

      @data = newData
    end

    # Sorts by the value of each PieDatum.
    # 
    # Largest value is first.
    # 
    # * *Args*    :
    #   - ++ -> 
    # * *Returns* :
    #   - 
    #
    def sort_by_value
      @data = @data.sort_by { |k, v| v.value }.reverse
    end

    def recalculate_total
      @total = 0.0

      @data.each do |label, value|

      end
    end
  end
end