# app/services/person/calculate_imc_service.rb
module Services 
  module Person
    class CalculateImcService < ServiceBase
      def initialize(weight:, height:)
        @weight = weight
        @height = height
      end

      def call
        return nil if weight.nil? || height.nil? || height.zero?

        (weight / (height ** 2)).round(2)
      end

      private

      attr_reader :weight, :height
    end
  end
end
