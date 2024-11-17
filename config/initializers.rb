require_relative '../models/modules/jsonable'
require_relative '../models/modules/objectable'
require_relative '../models/postgres_exporter'
require_relative '../models/csv_exporter'
require_relative '../models/record'
require_relative '../models/services/person/service_base'

base =  "#{File.dirname(__FILE__)}/.."

models = "#{base}/models/**/*.rb"

controllers = "#{base}/controllers/**/*.rb"

views = "#{base}/views/**/*.rb"

[views, models, controllers].each do |collection|
  files = Dir[collection]
  files.each {|file| require file }
end
