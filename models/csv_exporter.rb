# frozen_string_literal: true

require 'csv'
require 'fileutils'

class CsvExporter
  DATABASE_FILE = 'database/people.csv'

  def self.add_record(object) # rubocop:disable Metrics/AbcSize
    registrations_dir = File.dirname(DATABASE_FILE)
    Dir.mkdir(registrations_dir) unless Dir.exist?(registrations_dir)

    id = next_id

    CSV.open(DATABASE_FILE, 'a+') do |csv|
      csv << ['ID'] + object.class::ATTRIBUTES.map(&:to_s).map(&:capitalize) if csv.count.zero?

      csv << [id] + object.class::ATTRIBUTES.map { |attribute| object.send(attribute) }
    end

    puts "Registro adicionado ao arquivo #{DATABASE_FILE}"
  end

  private # rubocop:disable Lint/UselessAccessModifier

  def self.next_id # rubocop:disable Lint/IneffectiveAccessModifier
    return 1 unless File.exist?(DATABASE_FILE) && !File.zero?(DATABASE_FILE)

    last_id = 0

    CSV.foreach(DATABASE_FILE) do |row|
      last_id = row[0].to_i if row[0] =~ /^\d+$/
    end

    last_id + 1
  end
end
