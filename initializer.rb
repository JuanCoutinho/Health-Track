essential_modules = [
  'models/modules/jsonable',
  'models/modules/objectable',
  'models/postgres_exporter',
  'models/csv_exporter',
  'models/record',
  'views/inputs',
  'controllers/persons_controller'
]

essential_modules.each { |mod| require_relative mod }

Dir["./{models,controllers,views}/**/*.rb"].each { |file| require_relative file }
