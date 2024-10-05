# frozen_string_literal: true

class Record < PostgresExporter
  def as_json
    self.class::ATTRIBUTES.each_with_object({}) do |attr, acc|
      acc[attr] = send(attr)
    end
  end

  def self.format_value(value)
    case value
    when String
      "'#{PG::Connection.escape_string(value)}'"
    when Numeric
      value.to_s
    when NilClass
      'NULL'
    else
      raise "Unsupported value type: #{value.class}"
    end
  end

  def self.to_object(params)
    Person.new.tap do |obj|
      params.each { |key, value| obj.send("#{key}=", value) }
    end
  end
end
