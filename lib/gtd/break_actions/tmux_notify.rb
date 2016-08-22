module GTD::BreakActions
  class TmuxNotify < Base
    attr_reader :original_bg

    def initialize()
      @original_bg = `tmux show-options -g | grep status-style | sed 's/.*bg=\\(.*\\)$/\\1/' | tr -d '\\n'`
    end

    def reset
      %x(tmux set -g status-bg #{original_bg} > /dev/null)
    end

    def perform
      %x(tmux set -g status-bg red > /dev/null)
    end

    def quitting
      reset
    end
  end
end
