module Inputs

    def view_imc
        puts 'Digite seu peso (kg):'
        @person.weight = gets.chomp.to_f

        puts 'Digite sua altura (m):'
        @person.height = gets.chomp.to_f
    end

    def view_pam
        puts 'Digite seu PAS:'
        @person.pas = gets.chomp.to_f

        puts 'Digite seu PAD:'
        @person.pad = gets.chomp.to_f
    end

    def fetch_input
        puts 'Digite seu nome:'
        @person.nome = gets.chomp
    
        puts 'Digite seu email:'
        @person.email = gets.chomp
    end
    
    def fecth_search
        puts "Digite o ID da pessoa:"
        @id = gets.chomp.to_i
    end
end