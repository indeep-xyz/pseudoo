RSpec.shared_examples \
    'in Object, creating a new instance' do
  describe '.new' do
    context 'passed no arguments' do
      subject { described_class.new }

      it 'should create a new instance' do
        expect { subject }.not_to \
          raise_error
      end

      it 'should have an object as ::Object' do
        expect(subject.pseudoo_object).to \
          be_an_instance_of ::Object
      end
    end

    Contextant.in(%w/all/) \
        do |object, banner|
      context banner do
        it 'should raise ArgumentError' do
          expect { described_class.new(object) }.to \
            raise_error ::ArgumentError
        end
      end
    end
  end
end