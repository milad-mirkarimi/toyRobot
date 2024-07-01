# frozen_string_literal: true

require_relative '../lib/command_proccessor'

file_path = './data/commands.json'
input = File.read(file_path)
puts CommandProcessor.call(input)
