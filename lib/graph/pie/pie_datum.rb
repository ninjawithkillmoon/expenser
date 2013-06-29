module Graph::Pie
  class PieDatum
    attr_accessor :label, :value, :colour

    @@colours = ['#68BC31', '#2091CF', '#AF4E96', '#DA5430', '#FEE074', '#D6487E', '#FF8000', '#52E8FF', '#6BE879']
    @@coloursIndex = -1

    def initialize(label, value, colour=PieDatum.next_colour)
      @label = label
      @value = value
      @colour = colour
    end

    def self.next_colour
      @@coloursIndex = @@coloursIndex + 1
      return @@colours[@@coloursIndex % @@colours.size]
    end

    def self.reset_colour
      @@coloursIndex = -1
    end
  end
end