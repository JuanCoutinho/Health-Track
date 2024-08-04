#! /usr/bin/env ruby

`createdb test`

require 'pg'

conn = PG.connect(dbname: 'test')

query = %(
    CREATE TABLE IF NOT EXISTS people (
         id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
         nome VARCHAR(45) NOT NULL,
         email VARCHAR(30) NOT NULL UNIQUE,
         weight DECIMAL(4,2),
         height DECIMAL(4,2),
         pas DECIMAL(4,2),
         pad DECIMAL(4,2),
         imc DECIMAL(4,2),
         pam DECIMAL(4,2)
    )
) 

conn.exec(query) do |result|
    puts result
end