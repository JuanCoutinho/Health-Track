# frozen_string_literal: true

require 'pg'

class PostgresExporter
  DATABASE = 'test'

  def self.create(params); end

  def self.find(id)
    conn = ::PG.connect(dbname: DATABASE)

    query = %(
      select * from people where id = #{id}
    )
    object = nil
    conn.exec(query) do |result|
      object = to_object(result.first.except('id').transform_keys(&:to_sym))
    end
    object
  end
end
