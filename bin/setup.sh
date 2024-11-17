#! /usr/bin/env ruby

`createdb test`

require 'pg'

conn = PG.connect(dbname: 'test')

query = %(
    CREATE TABLE IF NOT EXISTS people (
         id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
         nome VARCHAR(45) NOT NULL,
         email VARCHAR(30) NOT NULL UNIQUE,
         weight DECIMAL(8,4),
         height DECIMAL(8,4),
         pas DECIMAL(8,4),
         pad DECIMAL(8,4),
         imc DECIMAL(8,4),
         pam DECIMAL(8,4),
         gender VARCHAR(10),
         age INTEGER
    )
) 

conn.exec(query) do |result|
    puts result
end