# frozen_string_literal: true

require 'json'
require_relative 'toy_robot'

class CommandProcessor
  def self.call(input)
    new.call(input)
  end

  def call(input)
    commands = JSON.parse(input)
    robot = ToyRobot.new
    reports = []

    commands.each do |command|
      case command['action']
      when 'PLACE'
        robot.place(command['x_axis'], command['y_axis'], command['facing'])
      when 'MOVE'
        robot.move
      when 'LEFT'
        robot.left
      when 'RIGHT'
        robot.right
      when 'REPORT'
        reports << robot.report
      else
        puts "Unknown command: #{command['action']}"
      end
    end

    reports.join("\n")
  end
end
