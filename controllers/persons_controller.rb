# frozen_string_literal: true

class PersonsController
  attr_reader :person

  def initialize
    @person = Person.new
  end

  def options
    {
      1 => { label: 'Cadastrar pessoa', action: -> { fetch_person } },
      2 => { label: 'Calcular IMC', action: -> { input_imc  } },
      3 => { label: 'Calcular Pam', action: -> { input_pam  } },
      4 => { label: 'Exibir informações', action: -> { display_person } },
      5 => { label: 'Salvar informações', action: -> { create } }
    }
  end

  def fetch_person
    puts 'Digite seu nome:'
    @person.nome = gets.chomp

    puts 'Digite seu email:'
    @person.email = gets.chomp

    puts 'Cadastrado com sucesso!'
  end

  def display_person
    puts 'Digite o id'
    id = gets.chomp

    person = Person.find(id)
    view = DisplayPerson.new(person)
    view.display
  end

  def input_imc
    puts 'Digite seu peso (kg):'
    @person.weight = gets.chomp.to_f

    puts 'Digite sua altura (m):'
    @person.height = gets.chomp.to_f

    @person.calculate_imc

    return puts "Seu IMC é: #{@person.imc}" if @person.imc

    puts 'Não foi possível calcular o IMC. Verifique os valores fornecidos.'
  end

  def input_pam
    puts 'Digite seu PAS:'
    @person.pas = gets.chomp.to_f

    puts 'Digite seu PAD:'
    @person.pad = gets.chomp.to_f

    @person.calculate_pam

    return puts "Seu PAM é: #{@person.pam}" if @person.pam

    puts 'Não foi possível calcular o PAM. Verifique os valores fornecidos.'
  end

  def create
    Person.create(person_params)
  end

  def person_params
    @person.as_json
  end
end
