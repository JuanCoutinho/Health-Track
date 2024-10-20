module Services
  module Person
    class CalculatePamService
      def initialize(pas, pad)
        @pas = pas
        @pad = pad
      end

      def self.call(pas, pad)
        new(pas, pad).call 
      end

      def call
        run
      end 

      private

      def run
        return nil if pas.nil? || pad.nil? || pad.zero?

        pam = (pas + 2 * pad) / 3.0
        pam.round(2)
      end
    end        
  end
end