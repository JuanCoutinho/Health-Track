# frozen_string_literal: true

require 'pg'

class PostgresExporter
  DATABASE = 'test'
  SCHEMA = 'people'

  def self.create(params)
    conn = ::PG.connect(dbname: DATABASE)

    columns = params.keys.join(', ')
    values = params.values.map { |val| format_value(val) }.join(', ')

    query = "INSERT INTO #{SCHEMA} (#{columns}) VALUES (#{values}) RETURNING id;"

    result = conn.exec(query)
    id = result.first['id']

    find(id)
  end

  def self.update(id, params)
    conn = ::PG.connect(dbname: DATABASE)

    set_clause = params.map do |key, value|
      formatted_value = format_value(value)
      "#{key} = #{formatted_value}"
    end.join(', ')

    query = "UPDATE #{SCHEMA} SET #{set_clause} WHERE id = #{id};"

    conn.exec(query)
    find(id)
  end

  def self.delete(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = "DELETE FROM #{SCHEMA} WHERE id = #{id};"

    conn.exec(query)
  end

  def self.find_last
    conn = ::PG.connect(dbname: DATABASE)

    query = "SELECT * FROM #{SCHEMA} ORDER BY id DESC LIMIT 1;"

    result = conn.exec(query)
    result.first
  end

  def self.find(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = "SELECT * FROM #{SCHEMA} WHERE id = #{id};"

    result = conn.exec(query)
    if result.ntuples.positive?
      to_object(result.first.transform_keys(&:to_sym))
    else
      puts "Nenhum registro encontrado com o ID #{id}."
      nil
    end
  end

  def self.format_value(value)
    return 'NULL' if value.nil?

    value = value.to_s.gsub("'", "''")
    "'#{value}'"
  end

  def self.to_object(attributes)
    Person.new(attributes)
  end
end
