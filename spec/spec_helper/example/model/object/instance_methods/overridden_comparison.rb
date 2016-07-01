RSpec.shared_examples \
    'in Object, overridden comparison instance methods' do

  describe '#kind_of?' do
    subject { described_class.wrap(value) }

    Contextant.in(%w/all/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        context 'when passed the class of the object mimicked by the receiver' do
          it 'should return true for the same value' do
            expect(subject.kind_of?(value.class)).to \
                be_truthy
          end
        end
      end
    end

    context 'has an instance of the described class' do
      let(:value) { described_class.wrap(nil) }

      context 'when passed the class of the receiver\'s root' do
        it 'should return true' do
          expect(subject.kind_of?(::PseudoObject::BasicObject)).to \
              be_truthy
        end
      end

      context 'when passed the class of object mimicked by the receiver' do
        it 'should return true' do
          expect(subject.kind_of?(described_class.pseudo_model)).to \
              be_truthy
        end
      end
    end
  end

  describe '#instance_of?' do
    subject { described_class.wrap(value) }

    Contextant.in(%w/all/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        context 'when passed the class of object mimicked by the receiver' do
          it 'should return true for the same value' do
            expect(subject.instance_of?(value.class)).to \
                be_truthy
          end
        end
      end
    end

    context 'has an instance of the described class' do
      let(:value) { described_class.allocate }

      context 'when passed the class of the receiver' do
        it 'should return true' do
          expect(subject.instance_of?(described_class)).to \
              be_truthy
        end
      end

      context 'when passed the class of the receiver\'s root' do
        it 'should return false' do
          expect(subject.instance_of?(::PseudoObject::BasicObject)).to \
              be_falsey
        end
      end

      context 'when passed the class of object mimicked by the receiver' do
        it 'should return false' do
          expect(subject.instance_of?(described_class.pseudo_model)).to \
              be_truthy
        end
      end
    end
  end
end