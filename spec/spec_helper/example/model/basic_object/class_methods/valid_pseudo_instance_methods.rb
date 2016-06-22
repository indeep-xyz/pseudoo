RSpec.shared_examples 'valid pseudo instance methods' do
  describe '.instance_methods_pseudized' do
    subject { described_class.instance_methods_pseudized }

    it 'should return an array' do
      is_expected.to \
          be_a_kind_of(::Array)
    end

    it 'should return instance methods including the original class\'s them' do
      original = described_class.pseudo_class.instance_methods
      addition = described_class.pseudo_instance_methods

      is_expected.to \
          match_array(original | addition)
    end
  end

  describe '.public_instance_methods_pseudized' do
    subject { described_class.public_instance_methods_pseudized }

    it 'should return an array' do
      is_expected.to \
          be_a_kind_of(::Array)
    end

    it 'should return public instance methods including the original class\'s them' do
      original = described_class::pseudo_class.public_instance_methods
      addition = described_class::pseudo_public_instance_methods

      is_expected.to \
          match_array(original | addition)
    end
  end
end