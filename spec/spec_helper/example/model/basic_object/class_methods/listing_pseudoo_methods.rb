RSpec.shared_examples \
    'in BasicObject, listing pseudoo methods' do
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
  # .pseudoo_* series

  describe '.pseudoo_instance_methods' do
    subject { described_class.pseudoo_instance_methods }

    it 'should return an array including valid instance methods' do
      is_expected.to \
          include(:pseudo?, :pseudoo_object, :pseudoo_object=)
      is_expected.not_to \
          include(:==)
    end
  end

  describe '.pseudoo_methods' do
    subject { described_class.pseudoo_methods }

    it 'should return an array including valid methods' do
      is_expected.to \
          include(:pseudoo_instance_methods)
      is_expected.not_to \
          include(:methods)
    end
  end

  describe '.pseudoo_private_instance_methods' do
    subject { described_class.pseudoo_private_instance_methods }

    it 'should return an array including valid private instance methods' do
      is_expected.to \
          include(:validate_pseudoo_class)
      is_expected.not_to \
          include()
    end
  end

  describe '.pseudoo_protected_instance_methods' do
    subject { described_class.pseudoo_protected_instance_methods }

    it 'should return an array including valid protected instance methods' do
      is_expected.to \
          include()
      is_expected.not_to \
          include(:methods)
    end
  end

  describe '.pseudoo_public_instance_methods' do
    subject { described_class.pseudoo_public_instance_methods }

    it 'should return an array including valid public instance methods' do
      is_expected.to \
          include(:pseudo?)
      is_expected.not_to \
          include(:__send__)
    end
  end

end