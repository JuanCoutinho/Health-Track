# frozen_string_literal: true
require_relative "csv_exporter"
require_relative "modules/jsonable"
require_relative "modules/objectable"

class Record < CsvExporter
  include Modules::Jsonable
  extend Modules::Objectable
end
