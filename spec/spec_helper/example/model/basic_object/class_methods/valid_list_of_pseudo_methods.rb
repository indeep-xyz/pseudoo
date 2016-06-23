RSpec.shared_examples 'valid list of pseudo methods' do
  # - - - - - - - - - - - - - - - - - - - -
  # .pseudized_* series

  %w/
  instance_methods
  methods
  private_instance_methods
  protected_instance_methods
  public_instance_methods
  /.each do |method_name|
    pseudized_method_name = "pseudized_#{method_name}"
    pseudo_method_name = "pseudo_#{method_name}"
    it_text = 'should return an array including %s and the model class\'s' % [
        pseudo_method_name.gsub(/_/, ' ')]

    describe ".#{pseudized_method_name}" do
      subject { described_class.__send__(pseudized_method_name) }

    it it_text do
      original = described_class.pseudo_class.__send__(method_name)
      addition = described_class.__send__(pseudo_method_name)

      is_expected.to \
          match_array(original | addition)
      end
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