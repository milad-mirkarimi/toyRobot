# frozen_string_literal: true

require 'spec_helper'
require 'toy_robot_app'
require 'json'

RSpec.describe ToyRobot do
  let(:case_A) do
    <<~JSON
      [
        { "action": "PLACE", "x_axis": 0, "y_axis": 0, "facing": "NORTH" },
        { "action": "MOVE" },
        { "action": "REPORT" }
      ]
    JSON
  end

  let(:case_B) do
    <<~JSON
      [
        { "action": "PLACE", "x_axis": 0, "y_axis": 0, "facing": "NORTH" },
        { "action": "LEFT" },
        { "action": "REPORT" }
      ]
    JSON
  end

  let(:case_C) do
    <<~JSON
      [
        { "action": "PLACE", "x_axis": 1, "y_axis": 2, "facing": "EAST" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "LEFT" },
        { "action": "MOVE" },
        { "action": "REPORT" }
      ]
    JSON
  end

  let(:edge_case) do
    <<~JSON
      [
        { "action": "PLACE", "x_axis": 4, "y_axis": 4, "facing": "EAST" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "MOVE" },
        { "action": "REPORT" }
      ]
    JSON
  end

  let(:invalid_place) do
    <<~JSON
      [
        { "action": "PLACE", "x_axis": -1, "y_axis": 3, "facing": "WEST" },
        { "action": "MOVE" },
        { "action": "RIGHT" },
        { "action": "MOVE" },
        { "action": "REPORT" }
      ]
    JSON
  end

  let(:expected_result_A) do
    '0,1,NORTH'
  end

  let(:expected_result_B) do
    '0,0,WEST'
  end

  let(:expected_result_C) do
    '3,3,NORTH'
  end

  let(:edge_case_result) do
    '4,4,EAST'
  end

  describe 'integration' do
    context 'when there is a move' do
      subject(:result) do
        json_result = ToyRobot.call(case_A)
        json_result
      end

      it 'outputs report in expected form' do
        expect(result).to eq(expected_result_A)
      end
    end

    context 'when there is a turn' do
      subject(:result) do
        json_result = ToyRobot.call(case_B)
        json_result
      end

      it 'outputs report in expected form' do
        expect(result).to eq(expected_result_B)
      end
    end

    context 'when there are multiple turns and moves' do
      subject(:result) do
        json_result = ToyRobot.call(case_C)
        json_result
      end

      it 'outputs report in expected form' do
        expect(result).to eq(expected_result_C)
      end
    end

    context 'when robot is placed at the edge of the table' do
      subject(:result) do
        json_result = ToyRobot.call(edge_case)
        json_result
      end

      it 'ignores the move command to not fall off the table' do
        expect(result).to eq(edge_case_result)
      end
    end

    context 'when place is invalid' do
      subject(:result) do
        json_result = ToyRobot.call(invalid_place)
        json_result
      end

      it 'ignores the commands' do
        expect(result).to eq('')
      end
    end
  end
end
