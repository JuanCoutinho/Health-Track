module Services
  module Person 
    class CalculateImcService
      def initialize(weight: nil, height: nil)
        @weight = weight
        @height = height
      end

      def call
        run
      end

      def self.call(weight: nil, height: nil)
        new(weight: weight, height: height).call
      end

      private 

      def run 
        return nil if @weight.nil? || @height.nil? || @height.zero?

        imc = @weight / (@height * 2)
        imc.round(2)
      end
    end
  end
end