# frozen_string_literal: true
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
end

require_relative '../config/initializers'

require 'rspec'
