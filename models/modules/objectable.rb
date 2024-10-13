module Modules
    module Objectable
      def to_object(params)
        self.new.tap do |obj|
          params.each { |key, value| obj.send("#{key}=", value) if key != 'id' }
        end
      end
    end
end