require_relative 'config/initializers'

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
