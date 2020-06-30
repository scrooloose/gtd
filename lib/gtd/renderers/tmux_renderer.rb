module GTD::Renderers
  class TmuxRenderer < Base
    attr_reader :fname

    def initialize(fname: "/tmp/tmux_gtd_statusbar")
      @fname = fname
    end

    def render(worked: nil, total: nil)
      File.open(fname, "w") do |f|
        f << bar(worked: worked, total: total)
      end
    end

    def cleanup
      File.unlink(fname)
    end

    private

      def bar(worked:, total:)
        width = 10
        worked_len = ((worked / total.to_f) * width).floor

        bar = "["
        bar << "-" * worked_len
        bar << "*" * (width - worked_len)
        bar << "] "
        bar
      end
  end
end
