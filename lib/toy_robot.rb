# frozen_string_literal: true

class ToyRobot
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  def initialize(**args)
    args = defaults.merge(args)

    @x_axis = nil
    @y_axis = nil
    @facing = nil
    @tabletop_width = args[:tabletop_width]
    @tabletop_height = args[:tabletop_height]
  end

  def self.call(input)
    new.call(input)
  end

  def call(input)
    commands = JSON.parse(input)
    reports = []

    commands.each do |command|
      case command['action']
      when 'PLACE'
        place(command['x_axis'], command['y_axis'], command['facing'])
      when 'MOVE'
        move
      when 'LEFT'
        left
      when 'RIGHT'
        right
      when 'REPORT'
        reports << report
      else
        puts "Unknown command: #{command['action']}"
      end
    end

    reports.join("\n")
  end

  def place(x_axis = 0, y_axis = 0, facing = 'NORTH')
    return unless valid_position?(x_axis, y_axis)

    self.x_axis = x_axis
    self.y_axis = y_axis
    self.facing = facing
  end

  def move
    return unless on_the_table?

    case facing
    when 'NORTH'
      self.y_axis += 1 if y_axis < tabletop_height - 1
    when 'EAST'
      self.x_axis += 1 if x_axis < tabletop_width - 1
    when 'SOUTH'
      self.y_axis -= 1 if y_axis.positive?
    when 'WEST'
      self.x_axis -= 1 if x_axis.positive?
    end
  end

  def left
    return unless on_the_table?

    self.facing = DIRECTIONS[DIRECTIONS.index(facing) - 1]
  end

  def right
    return unless on_the_table?

    self.facing = DIRECTIONS[(DIRECTIONS.index(facing) + 1) % 4]
  end

  def report
    return unless on_the_table?

    "#{x_axis},#{y_axis},#{facing}"
  end

  private

  def on_the_table?
    !x_axis.nil? && !y_axis.nil? && !facing.nil?
  end

  def valid_position?(x_axis, y_axis)
    x_axis.between?(0, tabletop_width) && y_axis.between?(0, tabletop_height)
  end

  def defaults
    { tabletop_width: 4, tabletop_height: 4 }
  end

  attr_accessor :x_axis, :y_axis, :facing
  attr_reader :tabletop_width, :tabletop_height
end
