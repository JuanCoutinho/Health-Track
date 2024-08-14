# frozen_string_literal: true

require 'pg'

class PostgresExporter
  DATABASE = 'test'

  def self.create(params)
    conn = ::PG.connect(dbname: DATABASE)
    vals = params.values.map { |val| val.nil? ? 'NULL' : %('#{val.is_a?(Numeric) ? '%.2f' % val : val }') }.join ', '

    query = %(
     insert into people(#{params.keys.join(', ')}) values (#{vals})
    )

    object = nil
 
    conn.exec(query) do |result|
      object = Person.new
      params.each { |param| object.send("#{param.first}=", param.last) }
    end
    object
  end

  def self.find(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = %(
      select * from #{self::SCHEMA} where id = #{id}
    )
    object = nil
    conn.exec(query) do |result|
      object = to_object(result.first.except('id').transform_keys(&:to_sym))
    end
    object
  end
end
