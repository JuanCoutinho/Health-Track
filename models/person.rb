# frozen_string_literal: true

class Person < Record
  SCHEMA = 'people'
  ATTRIBUTES = %i[nome email weight height pas pad imc pam gender age tmb].freeze
  attr_accessor(*ATTRIBUTES)
  #validates :weight, number: true, presence: true
  #validates :height, number: true, presence: true, format: :decimal

  def initialize; end # rubocop:disable Lint/MissingSuper

  def calculate_imc
    @imc = Services::Person::CalculateImcService.call(weight: @weight, height: @height)
  end

  def calculate_pam
    @pam = Services::Person::CalculatePamService.call(pas: @pas, pad: @pad)
  end

  def calculate_basal_metabolic_rate
    @tmb = Services::Person::CalculateBasalMetabolicService.call(gender: @gender, weight: @weight, height: @height,age: @age)
  end
end
