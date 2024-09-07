# frozen_string_literal: true

require './spec/models/spec_helper'
require_relative '../../models/menu'

RSpec.describe Menu do
  let(:controller) { double('Controller', new: instance_double('ControllerInstance', options: {})) }
  let(:menu) { described_class.new(controller) }

  describe '#show_options' do
    it 'prints the available options' do
      expect { menu.show_options }.to output(/Digite uma das opções abaixo:/).to_stdout
    end
  end

  describe '#select_option' do
    it 'calls the action for option 0 (end_app)' do
      allow(menu).to receive(:end_app)
      allow(menu).to receive(:gets).and_return('0')

      menu.select_option

      expect(menu).to have_received(:end_app)
    end
  end
end
