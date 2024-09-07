# frozen_string_literal: true

require 'pg'

class PostgresExporter
  DATABASE = 'test'
  SCHEMA = 'people'

  def self.create(params)
    conn = ::PG.connect(dbname: DATABASE)

    columns = params.keys.join(', ')
    values = params.values.map { |val| format_value(val) }.join(', ')

    query = <<-SQL
      INSERT INTO #{SCHEMA} (#{columns}) VALUES (#{values})
    SQL

    conn.exec(query)
    
    object = Person.new
    params.each { |key, value| object.send("#{key}=", value) }
    
    conn.close
    object
  end

  def self.update(id, params)
    conn = ::PG.connect(dbname: DATABASE)

    set_clause = params.map do |key, value|
      "#{key} = #{format_value(value)}"
    end.join(', ')

    query = <<-SQL
      UPDATE #{SCHEMA}
      SET #{set_clause}
      WHERE id = #{id}
    SQL

    conn.exec(query)
    conn.close

    find(id)
  end

  def self.delete(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = <<-SQL
      DELETE FROM #{SCHEMA} WHERE id = #{id}
    SQL

    conn.exec(query)
    conn.close
  end

  def self.find_last
    conn = ::PG.connect(dbname: DATABASE)

    query = <<-SQL
      SELECT * FROM #{SCHEMA} ORDER BY id DESC LIMIT 1
    SQL

    result = conn.exec(query)
    conn.close

    result.any? ? result.first : nil
  end

  def self.find(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = <<-SQL
      SELECT * FROM #{SCHEMA} WHERE id = #{id}
    SQL

    result = conn.exec(query)
    conn.close

    if result.any?
      to_object(result.first)
    else
      nil
    end
  end
end
