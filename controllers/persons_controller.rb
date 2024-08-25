# frozen_string_literal: true

class PersonsController
  include Inputs
  attr_reader :person

  def initialize
    @person = Person.new
  end

  def options
    {
      1 => { label: 'Cadastrar pessoa', action: -> { fetch_person } },
      2 => { label: 'Calcular IMC', action: -> { input_imc } },
      3 => { label: 'Calcular PAM', action: -> { input_pam } },
      4 => { label: 'Exibir informações', action: -> { display_person } },
      5 => { label: 'Salvar informações', action: -> { create } },
      6 => { label: 'Atualizar informações', action: -> { edit } },
      7 => { label: 'Excluir informações', action: -> { destroy } }
    }
  end

  def fetch_person
    fetch_input
    puts 'Cadastrado com sucesso!'
  end

  def display_person
    fecth_search
    person = Person.find(id)
    view = DisplayPerson.new(person)
    view.display
  end

  def input_imc
    view_imc
    @person.calculate_imc

    return puts "Seu IMC é: #{@person.imc}" if @person.imc

    puts 'Não foi possível calcular o IMC. Verifique os valores fornecidos.'
  end

  def input_pam
    view_pam
    @person.calculate_pam

    return puts "Seu PAM é: #{@person.pam}" if @person.pam

    puts 'Não foi possível calcular o PAM. Verifique os valores fornecidos.'
  end

  def create
    Person.create(person_params)
  end

  def edit
    fecth_search
    fetch_input
    person = Person.update(id, nome: nome, email: email)
    puts "Pessoa atualizada: #{person}"
  end

  def destroy
    puts "Digite o ID da pessoa:"
    id = gets.chomp.to_i

    Person.delete(id)
  end

  def person_params
    @person.as_json
  end
end
