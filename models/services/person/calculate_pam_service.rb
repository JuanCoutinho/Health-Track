module Services
  module Person
    class CalculatePamService 
      def initialize(pas: nil, pad: nil)
        @pas = pas
        @pad = pad
      end
      
      def call
        run
      end

      def self.call(pas: nil, pad: nil)
        new(pas: pas, pad: pad).call
      end

      private
       
      def run
        return nil if @pas.nil? || @pad.nil?

        pam = (@pas + 2 * @pad) / 3.0
        pam.round(2)
      end
    end
  end
end