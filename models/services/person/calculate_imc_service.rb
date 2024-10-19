module Services
  module Person 
    class CalculateImcService
      def self.call(weight:, height:)
        return nil if weight.nil? || height.nil? || height.zero?

        (weight / (height ** 2)).round(2)
      end
    end
  end
end