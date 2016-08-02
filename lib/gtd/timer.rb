module GTD
  class Timer
    attr_reader :work_period, :sleep_period, :break_actions, :progress_renderer

    def initialize(work_period: 1500, sleep_period: 60, break_actions: [], progress_renderer: ProgressRenderer)
      @work_period = work_period
      @sleep_period = sleep_period
      @break_actions = break_actions
      @progress_renderer = progress_renderer
    end

    def start
      while true
        break_actions.each(&:reset)
        do_work_period
        break_actions.each(&:perform)
        block_till_next_work_period_started
      end

      rescue Interrupt
        break_actions.each(&:quitting)
    end

    private
      def do_work_period
        worked_for = 0
        while worked_for < work_period
          clear
          puts progress_renderer.new(worked: worked_for, total: work_period).render

          sleep sleep_period
          worked_for += sleep_period
        end

        clear
        puts "End of work period (#{work_period / 60} mins). Take a break!\n\n"
      end

      def block_till_next_work_period_started
        puts "Enter to start next work period"
        gets
      end

      def clear
        system("clear")
      end
  end
end
