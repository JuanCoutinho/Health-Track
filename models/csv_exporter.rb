# frozen_string_literal: true

require 'csv'
require 'fileutils'

class CsvExporter
  DATABASE_FILE = 'database/people.csv'

  def self.create(params) # rubocop:disable Metrics/AbcSize
    object = to_object(params)
    registrations_dir = File.dirname(DATABASE_FILE)
    Dir.mkdir(registrations_dir) unless Dir.exist?(registrations_dir)

    id = next_id

    CSV.open(DATABASE_FILE, 'a+') do |csv|
      csv << ['ID'] + object.class::ATTRIBUTES.map(&:to_s).map(&:capitalize) if csv.count.zero?

      csv << [id] + object.class::ATTRIBUTES.map { |attribute| object.send(attribute) }
    end

    puts "Registro adicionado ao arquivo #{DATABASE_FILE}"
  end

  def self.find(id) # rubocop:disable Metrics/MethodLength
    result = nil

    CSV.foreach(DATABASE_FILE, headers: true) do |row|
      if row['ID'] == id.to_s
        params = self::ATTRIBUTES.each_with_object({}) do |attribute, hash|
          hash[attribute] = row[attribute.to_s.capitalize]
        end
        result = to_object(params)
        break
      end
    end

    result
  end

  def self.delete(id)
    rows = CSV.read(DATABASE_FILE, headers: true)
    headers = rows.headers

    rows = rows.reject { |row| row['ID'].to_i == id }

    CSV.open(DATABASE_FILE, 'w') do |csv|
      csv << headers
      rows.each { |row| csv << row }
    end

    puts "Registro com ID #{id} deletado."
  end

  def self.update(id, params) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize,Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
    unless File.exist?(DATABASE_FILE)
      puts 'Arquivo de banco de dados não encontrado.'
      return
    end

    rows = CSV.read(DATABASE_FILE, headers: true)
    headers = rows.headers

    rows_array = rows.map(&:to_hash)

    updated = false

    rows_array.each do |row|
      next unless row['ID'] == id.to_s

      updated = true

      params.each do |key, value|
        header_key = key.to_s.capitalize
        if headers.include?(header_key)
          row[header_key] = value
        else
          puts "Aviso: Cabeçalho '#{header_key}' não encontrado no CSV."
        end
      end
    end

    if updated
      CSV.open(DATABASE_FILE, 'w') do |csv|
        csv << headers
        rows_array.each do |row|
          csv << headers.map { |header| row[header] }
        end
      end
      puts "Registro com ID #{id} atualizado."
    else
      puts "Registro com ID #{id} não encontrado."
    end
  end

  def self.next_id
    return 1 unless File.exist?(DATABASE_FILE) && !File.zero?(DATABASE_FILE)

    last_id = 0

    CSV.foreach(DATABASE_FILE) do |row|
      last_id = row[0].to_i if row[0] =~ /^\d+$/
    end

    last_id + 1
  end
end
