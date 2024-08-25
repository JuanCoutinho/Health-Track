# frozen_string_literal: true

require 'pg'

class PostgresExporter
  DATABASE = 'test'

  def self.create(params)
    conn = ::PG.connect(dbname: DATABASE)
    vals = params.values.map { |val| val.nil? ? 'NULL' : %('#{val.is_a?(Numeric) ? '%.2f' % val : val }') }.join ', '

    query = %(
     insert into #{self::SCHEMA}(#{params.keys.join(', ')}) values (#{vals})
    )

    object = nil
 
    conn.exec(query) do |result|
      object = Person.new
      params.each { |param| object.send("#{param.first}=", param.last) }
    end
    object
  end
  
  def self.update(id, params)
    conn = ::PG.connect(dbname: DATABASE)
    set_clause = params.map { |key, value| "#{key} = #{value.nil? ? 'NULL' : "'#{value.is_a?(Numeric) ? '%.2f' % value : value }'"}" }.join(', ')

    query = %(
      update #{self::SCHEMA}
      set #{set_clause}
      where id = #{id}
    )

    conn.exec(query)
    find(id)
  end

  def self.delete(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = %(
      delete from #{self::SCHEMA} where id = #{id}
    )

    conn.exec(query)
  end

  def self.find_last
    conn = ::PG.connect(dbname: DATABASE)

    query = %(
      select * from #{self::SCHEMA} order by id desc limit 1
    )
    object = nil
    conn.exec(query) do |result|
      object = result.first
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
