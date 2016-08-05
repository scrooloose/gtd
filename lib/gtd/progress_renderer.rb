module GTD
  class ProgressRenderer
    attr_reader :worked, :total

    def initialize(worked: nil, total: nil)
      @worked = worked
      @total = total
    end

    def render
      system("clear")
      puts "Left: #{(total - worked) / 60}    Period: #{total / 60}\n\n#{bar}\n\n"
    end

    private

      def bar
        width = [`tput cols`.to_i - 2, 40].min
        worked_len = ((worked / total.to_f) * width).floor

        bar = "["
        bar << "-" * worked_len
        bar << "*" * (width - worked_len)
        bar << "]"
        bar
      end
  end
end
