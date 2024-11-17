# frozen_string_literal: true

class PersonsController
  include Inputs
  attr_reader :person

  def initialize
    @person = Person.new
  end

  # Opções do menu, incluindo a nova opção para TMB
  def options
    {
      1 => { label: 'Cadastrar pessoa', action: -> { fetch_person } },
      2 => { label: 'Calcular IMC', action: -> { input_imc } },
      3 => { label: 'Calcular PAM', action: -> { input_pam } },
      4 => { label: 'Calcular Taxa Metabólica Basal', action: -> { input_basal } },
      5 => { label: 'Exibir informações', action: -> { display_person } },
      6 => { label: 'Salvar informações', action: -> { create } },
      7 => { label: 'Atualizar informações', action: -> { edit } },
      8 => { label: 'Excluir informações', action: -> { destroy } }
    }
  end

  # Cadastra uma nova pessoa
  def fetch_person
    fetch_input
    puts 'Cadastrado com sucesso!'
  end

  # Exibe as informações de uma pessoa
  def display_person
    fetch_search
    person = Person.find(@id)
    if person
      view = DisplayPerson.new(person)
      view.display
    else
      puts "Pessoa com ID #{@id} não encontrada."
    end
  end

  # Calcula o IMC da pessoa
  def input_imc
    view_imc
   # return puts @person.errors unless @person.valid?
    @person.calculate_imc

    if @person.imc
      puts "Seu IMC é: #{@person.imc}"
    else
      puts 'Não foi possível calcular o IMC. Verifique os valores fornecidos.'
    end
  end

  # Calcula o PAM da pessoa
  def input_pam
    view_pam
    @person.calculate_pam

    if @person.pam
      puts "Seu PAM é: #{@person.pam}"
    else
      puts 'Não foi possível calcular o PAM. Verifique os valores fornecidos.'
    end
  end

  # Calcula a Taxa Metabólica Basal (TMB) da pessoa
  def input_basal
    puts 'Informe seu gênero (male/female):'
    @person.gender = gets.chomp.downcase
    puts 'Informe seu peso em kg:'
    @person.weight ||= gets.chomp.to_f
    puts 'Informe sua altura em cm:'
    @person.height ||= gets.chomp.to_f
    puts 'Informe sua idade em anos:'
    @person.age = gets.chomp.to_i
    @person.calculate_basal_metabolic_rate

    if @person.tmb
      puts "Sua Taxa Metabólica Basal é: #{@person.tmb} kcal/dia"
    else
      puts 'Não foi possível calcular a TMB. Verifique os valores fornecidos.'
    end
  end

  def create
    Person.create(@person.as_json)
    puts 'Pessoa salva com sucesso!'
  end

  # Atualiza as informações de uma pessoa
  def edit
    fetch_search
    person = Person.find(@id)
    if person
      fetch_input
      nome = @nome || person.nome
      email = @email || person.email
      Person.update(@id, nome: nome, email: email)
      puts 'Pessoa atualizada com sucesso!'
    else
      puts "Pessoa com ID #{@id} não encontrada."
    end
  end

  # Exclui uma pessoa do sistema
  def destroy
    puts 'Digite o ID da pessoa:'
    @id = gets.chomp.to_i

    if Person.find(@id)
      Person.delete(@id)
      puts "Pessoa com ID #{@id} deletada com sucesso!"
    else
      puts "Pessoa com ID #{@id} não encontrada."
    end
  end

  # Método para buscar a pessoa pelo ID
  def fetch_search
    puts 'Digite o ID da pessoa:'
    @id = gets.chomp.to_i
  end

  # Retorna os parâmetros da pessoa como JSON
  def person_params
    @person.as_json
  end
end
