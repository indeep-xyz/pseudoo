require 'spec_helper'

describe PseudoObject do
  it 'has a version number' do
    expect(PseudoObject::VERSION).not_to \
        be(nil)
  end
end
