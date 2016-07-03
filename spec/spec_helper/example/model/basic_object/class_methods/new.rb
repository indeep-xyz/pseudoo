RSpec.shared_examples \
    'in BasicObject, creating a new instance' do
  describe '.new' do
    context 'passed no arguments' do
      subject { described_class.new }

      it 'should create a new instance' do
        expect { subject }.not_to \
          raise_error
      end

      it 'should have an object' do
        expect(subject.pseudo_object).not_to \
          be_nil
      end
    end

    context 'passed an argument' do
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
end