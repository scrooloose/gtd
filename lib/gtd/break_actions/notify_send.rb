module GTD::BreakActions
  class NotifySend < Base
    def perform
      %x(notify-send "Break time")
    end
  end
end
