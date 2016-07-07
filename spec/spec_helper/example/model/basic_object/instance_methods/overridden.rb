RSpec.shared_examples \
    'in BasicObject, overridden instance methods' do

  describe '#==' do
    subject { described_class.new }

    context 'when passed the same object as the receiver' do
      it 'should return true' do
        expect(subject == subject).to \
            be_truthy
      end
    end

    context 'when passed an object the receiver has' do
      it 'should return true' do
        expect(subject == subject.pseudoo_object).to \
            be_truthy
      end
    end

    context 'when passed an instance of ::BasicObject' do
      let(:value) { ::BasicObject.new }

      it 'should return false' do
        expect(subject == value).to \
            be_falsey
      end
    end
  end

  describe '#!=' do
    subject { described_class.new }

    context 'when passed the same object as the receiver' do
      it 'should return false' do
        expect(subject != subject).to \
            be_falsey
      end
    end

    context 'when passed an object the receiver has' do
      it 'should return false' do
        expect(subject != subject.pseudoo_object).to \
            be_falsey
      end
    end

    context 'when passed an instance of ::BasicObject' do
      let(:value) { ::BasicObject.new }

      it 'should return true' do
        expect(subject != value).to \
            be_truthy
      end
    end
  end

  describe '#!' do
    subject { described_class.new }

    it 'should return false' do
      expect(!subject).to \
          be_falsey
    end
  end
end