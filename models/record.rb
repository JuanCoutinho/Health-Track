# frozen_string_literal: true

class Record < PostgresExporter
  def as_json
    self.class::ATTRIBUTES.each_with_object({}) do |attr, acc|
      acc[attr] = send(attr)
    end
  end

  def self.to_object(params)
    object = new
    params.each { |key, value| object.send("#{key}=", value) }
    object
  end
end
