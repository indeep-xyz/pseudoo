RSpec.shared_examples 'valid pseudo methods' do
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

  describe '.pseudo_instance_methods' do
    subject { described_class.pseudo_instance_methods }

    it 'should return an array including valid instance methods' do
      is_expected.to \
          include(:pseudo?, :pseudo_object, :pseudo_object=)
      is_expected.not_to \
          include(:==)
    end
  end

  describe '.pseudo_methods' do
    subject { described_class.pseudo_methods }

    it 'should return an array including valid methods' do
      is_expected.to \
          include(:pseudo_instance_methods)
      is_expected.not_to \
          include(:methods)
    end
  end

  describe '.pseudo_private_instance_methods' do
    subject { described_class.pseudo_private_instance_methods }

    it 'should return an array including valid private instance methods' do
      is_expected.to \
          include(:validate_class)
      is_expected.not_to \
          include()
    end
  end

  describe '.pseudo_protected_instance_methods' do
    subject { described_class.pseudo_protected_instance_methods }

    it 'should return an array including valid protected instance methods' do
      is_expected.to \
          include()
      is_expected.not_to \
          include(:methods)
    end
  end

  describe '.pseudo_public_instance_methods' do
    subject { described_class.pseudo_public_instance_methods }

    it 'should return an array including valid public instance methods' do
      is_expected.to \
          include(:pseudo?)
      is_expected.not_to \
          include(:__send__)
    end
  end

end