RSpec.shared_examples 'valid list of pseudo methods' do
  # - - - - - - - - - - - - - - - - - - - -
  # .pseudized_* series

  describe '.pseudized_instance_methods' do
    subject { described_class.pseudized_instance_methods }

    it 'should return an array including instance methods overridden' do
      is_expected.to \
          include(:==, :!=, :!)
      is_expected.not_to \
          include(:instance_eval, :__send__, :__id__)
    end
  end

  # - - - - - - - - - - - - - - - - - - - -
  # .pseudo_* series

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
          include(:validate_pseudo_class)
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