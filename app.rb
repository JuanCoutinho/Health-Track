# frozen_string_literal: true

require_relative 'controllers/persons_controller'
require_relative 'models/person'
require_relative 'views/display_person'
require_relative 'models/menu'
require_relative 'models/csv_exporter'
require 'csv'

class App
  def call
    menu = Menu.new(PersonsController)

    loop do
      menu.show_options
      menu.select_option
    end
  end
end

App.new.call
