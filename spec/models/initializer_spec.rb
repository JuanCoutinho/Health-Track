require_relative '../spec_helper'
require_relative '../../config/initializers'

RSpec.describe 'Initializer' do
  it 'carrega todos os arquivos sem erros' do
    expect { require_relative '../../config/initializers' }.not_to raise_error
  end

  it 'define a constante DummyController' do
    expect(defined?(DummyController)).to eq('constant')
  end

  it 'define a constante Menu' do
    expect(defined?(Menu)).to eq('constant')
  end
end
