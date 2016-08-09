module GTD::Renderers
  class ProgressRenderer < Base
    def render(worked: nil, total: nil)
      system("clear")
      b = bar(worked: worked, total: total)
      puts "Left: #{(total - worked) / 60}    Period: #{total / 60}\n\n#{b}\n\n"
    end

    private

      def bar(worked: nil, total: nil)
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
