module GTD::BreakActions
  class BansheePause < Base
    def perform
      `banshee --pause`
    end
  end
end
