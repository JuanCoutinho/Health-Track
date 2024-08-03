# frozen_string_literal: true

require 'simplecov'

class Rspec
  SimpleCov.start do
    add_filter '/spec/'
  end
end
