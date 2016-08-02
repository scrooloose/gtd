#!/usr/bin/env ruby

require File.dirname(__FILE__) + "/../lib/gtd"

GTD::Timer.new(
  work_period: 25 * 60,

  break_actions: [
    GTD::BreakActions::NotifySend.new,
    GTD::BreakActions::BansheePause.new,
    GTD::BreakActions::TmuxNotify.new,
    GTD::BreakActions::Ding.new
  ]
).start

