module Services
  module Person
    class CalculateBasalMetabolicService < ServiceBase

      def initialize(gender:, weight:, height:, age:)
        @gender = gender
        @weight = weight
        @height = height
        @age = age
      end

      def call
        return nil if gender.nil? || weight.nil? || height.nil? || age.nil?
 
        case gender.downcase
        when 'male'
          tmb = 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * age)
        when 'female'
          tmb = 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * age)
        else
          return nil
        end

        tmb.round(2)
      end

      private

      attr_reader :gender, :weight, :height, :age
    end
  end
end
