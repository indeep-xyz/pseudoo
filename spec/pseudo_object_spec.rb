require 'spec_helper'

describe PseudoObject do
  it 'has a version number' do
    expect(PseudoObject::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
