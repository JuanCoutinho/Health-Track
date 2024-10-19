module Services
  module Person
    class CalculatePamService
      def self.call(pas:, pad:)
        return nil if pas.nil? || pad.nil? || pad.zero?

        pam = (pas + 2 * pad) / 3.0
        pam.round(2)
      end
    end        
  end
end