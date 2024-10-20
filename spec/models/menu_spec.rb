# frozen_string_literal: true

require 'spec_helper'

class DummyController
  def options
    {
      1 => { label: 'Option 1', action: -> { puts 'Action 1 executed.' } },
      2 => { label: 'Option 2', action: -> { puts 'Action 2 executed.' } }
    }
  end
end

RSpec.describe Menu do # rubocop:disable Metrics/BlockLength
  subject(:menu) { Menu.new(DummyController) }

  describe '#show_options' do
    it 'displays the menu options correctly' do
      expected_output = "Digite uma das opções abaixo:\n0. Sair\n1. Option 1\n2. Option 2\n"
      expect { menu.show_options }.to output(expected_output).to_stdout
    end
  end

  describe '#select_option' do
    context 'when a valid option is selected' do
      it 'executes the corresponding action' do
        allow(menu).to receive(:gets).and_return('1')
        expect { menu.select_option }.to output("Action 1 executed.\n").to_stdout
      end
    end

    context 'when an invalid option is selected' do
      it 'displays an error message' do
        allow(menu).to receive(:gets).and_return('99')
        expect { menu.select_option }.to output("Opção inválida.\n").to_stdout
      end
    end

    context 'when the exit option is selected' do
      it 'exits the application' do
        allow(menu).to receive(:gets).and_return('0')
        expect { menu.select_option }.to output("Saindo...\n").to_stdout
      end
    end
  end
end
