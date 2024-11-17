module Services
  module Person
    class CalculatePamService < ServiceBase

      def initialize(pas:, pad:)
        @pas = pas
        @pad = pad
      end

      def call
        return nil if pas.nil? || pad.nil? || pad.zero?

        pam = (pas + 2 * pad) / 3.0
        pam.round(2)
      end

      private

      attr_reader :pas, :pad
    end
  end
end
