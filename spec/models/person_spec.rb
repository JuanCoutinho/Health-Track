# frozen_string_literal: true

require_relative '../../models/person'

RSpec.describe Person do
  context '#calculate_imc' do
    it 'returns 25.0 for weight 90 height 1.8' do
      subject.weight = 90
      subject.height = 1.8

      subject.calculate_imc

      expect(subject.imc).to eq(25.0)
    end
  end
end
