RSpec.shared_examples \
    'in BasicObject, not overridden instance methods' do

  describe '#__id__' do
    subject { described_class.new }

    it 'should return an integer as object id' do
        expect(subject.__id__).to \
            be_a_kind_of(::Integer)
    end
  end

  describe '#__send__' do
    subject { described_class.new }

    context 'when passed an exist method name' do
      it 'should proccess correctly' do
        expect(subject.__send__('pseudo?')).to \
            be_truthy
      end
    end
  end

  describe '#equal?' do
    subject { described_class.new }

    context 'when passed an instance of ::BasicObject' do
      let(:value) { ::BasicObject.new }

      it 'should return false' do
        expect(subject.equal?(value)).to \
            be_falsey
      end
    end
  end
end