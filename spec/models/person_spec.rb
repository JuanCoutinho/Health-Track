# frozen_string_literal: true

require_relative '../spec_helper'
require_relative '../../models/postgres_exporter'
require_relative '../../models/record'
require_relative '../../models/person'
require 'simplecov'

RSpec.describe Person do
  context '#calculate_imc' do
    it 'returns 25.0 for weight 90 height 1.8' do
      subject.weight = 90
      subject.height = 1.8

      subject.calculate_imc

      expect(subject.imc).to eq(25.0)
    end
  end

  context '#calculate_pam' do
    it 'returns 93.33 for pas 120 pad 80' do
      subject.pas = 120
      subject.pad = 80

      subject.calculate_pam

      expect(subject.pam).to eq(93.33)
    end
  end
end
