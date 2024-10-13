# frozen_string_literal: true

class Record < PostgresExporter
  include Modules::Jsonable
  extend Modules::Objectable
end
