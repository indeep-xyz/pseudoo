RSpec.shared_examples \
    'in BasicObject, not overridden instance methods' do

  describe '#__id__' do
    subject { described_class.wrap(value) }

    Contextant.in(%w/fixnum string/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        it 'should return an object id' do
            expect(subject.__id__).to \
                be_a_kind_of(::Integer)
        end
      end
    end
  end

  describe '#__send__' do
    subject { described_class.wrap(value) }

    Contextant.in(%w/fixnum string/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        it 'should have the passed value' do
            expect(subject.__send__('pseudo_object')).to \
                eq(value)
        end
      end
    end
  end

  describe '#equal?' do
    subject { described_class.wrap(value) }

    Contextant.in(%w/fixnum string/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        context 'when passed the same object as the receiver' do
          it 'should return true' do
            expect(subject.equal?(subject)).to \
                be_truthy
          end
        end

        context 'when passed the object mimicked by the receiver' do
          it 'should return false' do
            expect(subject.equal?(value)).to \
                be_falsey
          end
        end
      end
    end
  end
end