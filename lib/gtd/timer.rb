require 'io/console'

module GTD
  class Timer
    attr_reader :work_period, :sleep_period, :break_actions, :renderers

    def initialize(work_period: 1500, sleep_period: 60, break_actions: [], renderers: [])
      @work_period = work_period
      @sleep_period = sleep_period
      @break_actions = break_actions
      @renderers = renderers
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
      renderers.each(&:cleanup)
    end

    private
      def do_work_period
        worked_for = 0
        while worked_for <= work_period
          render(worked_for)

          sleep sleep_period
          worked_for += sleep_period
        end
      end

      def render(worked_for)
        renderers.each do |renderer|
          renderer.render(worked: worked_for, total: work_period)
        end
      end

      def block_till_next_work_period_started
        breakstart = Time.now.to_i

        #discard any keys before the break
        STDIN.iflush

        loop do
          clear
          breakmins = ((Time.now.to_i - breakstart) / 60.0).to_i

          output =  "BREAK TIME\n==========\n\n"
          output << "Worked: #{work_period / 60} mins\n"
          output << "Current break: #{breakmins} mins\n\n"
          output << "Press Enter to start next work period."
          puts output

          char = STDIN.read_nonblock(1) rescue nil
          break if char

          sleep(0.5)
        end
      end

      def clear
        system("clear")
      end
  end
end
