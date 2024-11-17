# frozen_string_literal: true

require_relative '../spec_helper'
require 'pg'
require_relative '../../models/postgres_exporter'

class Person
  attr_accessor :id, :name, :age

  def initialize(id: nil, name: nil, age: nil)
    @id = id
    @name = name
    @age = age
  end
end

RSpec.describe PostgresExporter do # rubocop:disable Metrics/BlockLength
  let(:connection) { instance_double('PG::Connection') }

  before do
    allow(::PG).to receive(:connect).with(dbname: 'test').and_return(connection)
    allow(connection).to receive(:exec)
  end

  shared_examples 'executes a query' do |method, params, expected_query|
    it "executes #{method}" do
      PostgresExporter.send(method, *params)
      expect(connection).to have_received(:exec).with(expected_query)
    end
  end

  describe '.create' do
    it 'returns a Person object' do
      params = { name: 'John Doe', age: 30 }
      person = PostgresExporter.create(params)
      expect(person).to eq(Person.new(name: 'John Doe', age: 30))
    end
  end

  describe '.update' do
    include_examples 'executes a query', :update, [1, { name: 'Jane Doe', age: 25 }], /UPDATE people/
  end

  describe '.delete' do
    include_examples 'executes a query', :delete, [1], /DELETE FROM people/
  end

  describe '.find_last' do
    it 'returns the last Person' do
      allow(connection).to receive(:exec).and_return(instance_double('PG::Result', any?: true, first: { 'name' => 'Last Person' }))
      person = PostgresExporter.find_last
      expect(person['name']).to eq('Last Person')
    end
  end

  describe '.find' do
    it 'returns a Person object' do
      allow(connection).to receive(:exec).and_return(instance_double('PG::Result', any?: true, first: { 'name' => 'John Doe' }))
      person = PostgresExporter.find(1)
      expect(person['name']).to eq('John Doe')
    end
  end
end
