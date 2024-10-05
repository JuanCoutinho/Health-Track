# frozen_string_literal: true

class Menu
  def initialize(controller)
    @controller = controller.new

    @options = { 0 => { label: 'Sair', action: -> { end_app } } }
    @options = @options.merge(@controller.options)
  end

  def show_options
    puts 'Digite uma das opções abaixo:'
    @options.each { |key, value| puts "#{key}. #{value[:label]}" }
  end

  def select_option
    option = gets.chomp.to_i
    if @options.key?(option)
      @options[option][:action].call
    else
      puts "Opção inválida.\n"
    end
  end

  def end_app
    puts 'Saindo...'
    exit
  end
end
