module Modules
  module Jsonable
    def as_json
        self.class::ATTRIBUTES.each_with_object({}) do |attr, acc|
        acc[attr] = send(attr)
      end
    end
  end
end