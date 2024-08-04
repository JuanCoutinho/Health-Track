# frozen_string_literal: true

class DisplayPerson
  def initialize(person)
    @person = person
  end

  def display # rubocop:disable Metrics/MethodLength
    puts <<~HEREDOC
      Informações de #{@person.nome}
      Nome: #{@person.nome}
      Email: #{@person.email}
      Peso (kg): #{@person.weight}
      Altura (m): #{@person.height}
      IMC: #{@person.imc}
      PAS: #{@person.pas}
      PAD: #{@person.pad}
      PAM: #{@person.pam}
    HEREDOC
  end
end
