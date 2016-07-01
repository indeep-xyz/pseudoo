RSpec.shared_examples \
    'instance methods not being' do
  subject { described_class.wrap(value) }

  describe '#__instance_method_not_being__' do
    Contextant.in(%w/fixnum string/) \
        do |object, banner|
      context banner do
        let(:value) { object }
        let(:method_name) { '__instance_method_not_being__' }
        let(:regexp) {
          pattern = 'undefined method `%s\'[^:]*:%s$' % [
              method_name,
              subject.pseudo_object.class.name]

          Regexp.new(pattern)
        }

        it 'should raise NoMethodError in @pseudo_object' do
          expect { subject.__send__(method_name) }.to \
              raise_error(::NoMethodError, regexp)
        end
      end
    end
  end

end