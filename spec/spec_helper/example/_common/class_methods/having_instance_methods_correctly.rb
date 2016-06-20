RSpec.shared_examples 'having instance methods correctly' do
  describe '.instance_methods' do
    subject { described_class.instance_methods }

    it 'should return an array' do
      is_expected.to \
          be_a_kind_of(::Array)
    end

    it 'should include instance methods' do
      original = described_class::PSEUDO_CLASS.instance_methods
      addition = described_class::PSEUDO_INSTANCE_METHODS

      is_expected.to \
          match_array(original | addition)
    end
  end
end