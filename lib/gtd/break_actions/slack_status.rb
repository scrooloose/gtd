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
        set_dnd
      end

      def set_available
        set_status(text: "", emoji: "")
        end_dnd
      end

      def set_status(text:, emoji:)
        post(
          url: status_url,
          body: {
            "profile": {
              "status_text": text,
              "status_emoji": emoji
            }
          }
        )
      end

      def set_dnd
        post(url: 'https://slack.com/api/dnd.setSnooze?num_minutes=1000')
      end

      def end_dnd
        post(url: 'https://slack.com/api/dnd.endDnd')
      end

      def post(url:, body: '')
        HTTParty.post(
          url,
          body: body.to_json,
          headers: {
            'content-type' => 'application/json',
            'authorization' => "Bearer #{slack_token}"
          }
        )
      end
  end
end
