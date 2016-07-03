RSpec.shared_examples \
    'in BasicObject, instance methods not being' do
  subject { described_class.new }

  describe '#__instance_method_not_being__' do
    let(:method_name) { '__instance_method_not_being__' }
    let(:regexp) {
      pattern = '^undefined method `%s\'[^#]*#<Object:[^>]+>$' % [
          method_name]

      Regexp.new(pattern)
    }

    it 'should raise NoMethodError in @pseudo_object' do
      expect { subject.__send__(method_name) }.to \
          raise_error(::NoMethodError, regexp)
    end
  end
end