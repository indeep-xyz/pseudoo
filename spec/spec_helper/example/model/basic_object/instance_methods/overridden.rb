RSpec.shared_examples 'overridden instance methods of BasicObaject' do
  subject { described_class.new(value) }

  describe '#==' do
    Contextant.in(%w/all/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        it 'should return true for the same value' do
          expect(subject == value).to \
              be_truthy
        end
      end
    end
  end

  describe '#!=' do
    Contextant.in(%w/fixnum string bool nil/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        it 'should return false for the same value' do
          expect(subject != value).to \
              be_falsey
        end
      end
    end
  end

  describe '#!' do
    Contextant.in(%w/all/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        it 'should return the same as the returner of original object' do
          expect(!subject).to \
              eq(!value)
        end
      end
    end
  end
end