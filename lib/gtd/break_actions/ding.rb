module GTD::BreakActions
  class Ding < Base
    def perform
      `paplay --volume=50000 /usr/share/sounds/freedesktop/stereo/complete.oga`
    end
  end
end
