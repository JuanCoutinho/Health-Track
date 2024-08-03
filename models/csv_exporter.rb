require 'csv'
require 'fileutils'

class CsvExporter
  # Define o caminho para o arquivo CSV que servirá como banco de dados
  DATABASE_FILE = 'database/people.csv'

  # O método agora aceita apenas um argumento
  def self.add_record(object)
    # Garante que o diretório existe
    registrations_dir = File.dirname(DATABASE_FILE)
    Dir.mkdir(registrations_dir) unless Dir.exist?(registrations_dir)

    # Gera o próximo ID numérico
    id = next_id

    # Adiciona o novo registro ao final do arquivo CSV
    CSV.open(DATABASE_FILE, 'a+') do |csv|
      # Se o arquivo está vazio ou apenas contém o cabeçalho
      if csv.count.zero?
        # Adiciona o cabeçalho com o ID e os atributos
        csv << ['ID'] + object.class::ATTRIBUTES.map(&:to_s).map(&:capitalize)
      end

      # Adiciona os dados da instância ao CSV, incluindo o ID
      csv << [id] + object.class::ATTRIBUTES.map { |attribute| object.send(attribute) }
    end
    puts "Registro adicionado ao arquivo #{DATABASE_FILE}"
  end

  private

  # Gera o próximo ID numérico
  def self.next_id
    # Se o arquivo não existe ou está vazio, inicializa com o ID 1
    return 1 unless File.exist?(DATABASE_FILE) && !File.zero?(DATABASE_FILE)

    last_id = 0

    # Lê o último ID da primeira coluna do arquivo CSV
    CSV.foreach(DATABASE_FILE) do |row|
      last_id = row[0].to_i if row[0] =~ /^\d+$/
    end

    # Retorna o próximo ID
    last_id + 1
  end
end
