module GTD::BreakActions
  class Ding < Base
    def perform

      #fork this off so we dont have to wait for the sound to finish before
      #proceeding
      fork do
        `paplay --volume=50000 /usr/share/sounds/freedesktop/stereo/complete.oga`
      end
    end
  end
end
