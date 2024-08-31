# frozen_string_literal: true

require 'pg'

class PostgresExporter
  DATABASE = 'test'

  def self.create(params) # rubocop:disable Metrics/MethodLength
    conn = ::PG.connect(dbname: DATABASE)

    vals = params.values.map { |val| format_value(val) }.join(', ')

    query = %(
     insert into #{self::SCHEMA}(#{params.keys.join(', ')}) values (#{vals})
    )

    object = nil

    conn.exec(query) do |_result|
      object = Person.new
      params.each { |param| object.send("#{param.first}=", param.last) }
    end
    object
  end

  def self.update(id, params) # rubocop:disable Metrics/MethodLength
    conn = ::PG.connect(dbname: DATABASE)

    set_clause = params.map do |key, value|
      formatted_value = format_value(value)
      "#{key} = #{formatted_value}"
    end.join(', ')

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

  def self.find(id) # rubocop:disable Metrics/MethodLength
    conn = ::PG.connect(dbname: DATABASE)

    query = %(
      SELECT * FROM #{self::SCHEMA} WHERE id = #{id}
    )

    object = nil
    conn.exec(query) do |result|
      # Verifica se result.first é nil antes de chamar except
      if result.ntuples.positive?
        first_row = result.first
        object = to_object(first_row.transform_keys(&:to_sym).except(:id))
      else
        puts "Nenhum registro encontrado com o ID #{id}."
      end
    end
    object
  end
end
