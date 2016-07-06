RSpec.shared_examples \
    'in Object, overridden comparison instance methods' do

  describe '#kind_of?' do
    subject { described_class.new }

    context 'when passed the class of the receiver' do
      it 'should return true' do
        expect(subject.kind_of?(described_class)).to \
            be_truthy
      end
    end

    context 'when passed the class object mimicked by the receiver' do
      let(:model_class) { described_class.pseudo_model }

      it 'should return true' do
        expect(subject.kind_of?(model_class)).to \
            be_truthy
      end
    end

    context 'when passed the class of the receiver\'s root' do
      it 'should return true' do
        expect(subject.kind_of?(::Pseudoo::BasicObject)).to \
            be_truthy
      end
    end
  end

  describe '#instance_of?' do
    subject { described_class.new }

    context 'when passed the class of the receiver' do
      it 'should return true' do
        expect(subject.instance_of?(described_class)).to \
            be_truthy
      end
    end

    context 'when passed the class object mimicked by the receiver' do
      let(:model_class) { described_class.pseudo_model }

      it 'should return true for the same value' do
        expect(subject.instance_of?(model_class)).to \
            be_truthy
      end
    end

    context 'when passed the class of the receiver\'s root' do
      it 'should return false' do
        expect(subject.instance_of?(::Pseudoo::BasicObject)).to \
            be_falsey
      end
    end
  end
end