module GTD::BreakActions
  class SlackStatus
    def initialize(slack_token: ENV['GTD_SLACK_TOKEN'])
      @slack_token = slack_token
      @status_url = 'https://slack.com/api/users.profile.set'
    end

    def reset
      set_busy
    end

    def perform
      set_available
    end

    def quitting
      set_available
    end

    private

      attr_reader :slack_token, :status_url

      def set_busy
        set_status(text: "Concentrating", emoji: ":thinking_face:")
      end

      def set_available
        set_status(text: "", emoji: "")
      end

      def set_status(text:, emoji:)
        payload = {
          "profile": {
            "status_text": text,
            "status_emoji": emoji
          }
        }

        HTTParty.post(
          status_url,
          body: payload.to_json,
          headers: {
            'content-type' => 'application/json',
            'authorization' => "Bearer #{slack_token}"
          }
        )

      end
  end
end
