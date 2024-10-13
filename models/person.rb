# frozen_string_literal: true

class Person < Record
  SCHEMA = 'people'
  ATTRIBUTES = %i[nome email weight height pas pad imc pam].freeze
  attr_accessor(*ATTRIBUTES)

  def initialize; end # rubocop:disable Lint/MissingSuper

  def calculate_imc
    @imc = Services::Person::CalculateImcService.call(weight: @weight, height: @height)
  end

  def calculate_pam
    @pam = Services::Person::CalculatePamService.call(pas: @pas, pad: @pad)
  end
end
