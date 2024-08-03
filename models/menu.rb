# frozen_string_literal: true

class Menu
  def initialize(controller)
    @controller = controller.new

    @options = { 0 => { label: 'Sair', action: -> { end_app } } }
    @options = @options.merge(@controller.options)

    @options.default = { action: -> { puts "Opção inválida.\n" } }
  end

  def show_options
    puts 'Digite uma das opções abaixo:'

    @options.each { |option| puts "#{option.first}.#{option.last[:label]}" }
  end

  def select_option
    @options[gets.chomp.to_i][:action].call
  end

  def end_app
    puts 'Saindo...'
    exit
  end
end
