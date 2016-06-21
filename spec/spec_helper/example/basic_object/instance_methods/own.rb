RSpec.shared_examples 'own instance methods of BasicObaject' do
  subject { described_class.new(value) }

  describe '#pseudo?' do
    Contextant.in(%w/fixnum/) \
        do |object, banner|
      context banner do
        let(:value) { object }

        it 'should return an object id' do
          expect(subject.pseudo?).to \
              be_truthy
        end
      end
    end
  end

  describe '#pseudo_influence?' do
    subject { described_class.new(nil, influence: bool) }

    context 'when initialized no option for @pseudo_influence' do
      subject { described_class.new(nil) }

      it 'should return true' do
        expect(subject.pseudo_influence?).to \
            be_truthy
      end
    end

    context 'when initialized @pseudo_influence to true' do
      let(:bool) { true }

      it 'should return true' do
        expect(subject.pseudo_influence?).to \
            be_truthy
      end
    end

    context 'when initialized @pseudo_influence to false' do
      let(:bool) { false }

      it 'should return false' do
        expect(subject.pseudo_influence?).to \
            be_falsey
      end
    end
  end

  describe '#pseudo_influence=' do
    subject { described_class.new(nil, influence: bool) }

    context 'when initialized @pseudo_influence to true' do
      let(:bool) { true }

      context 'when passed false to #pseudo_influence=' do
        it 'should have false' do
          subject.pseudo_influence = false
          expect(subject.pseudo_influence?).to \
              be_falsey
        end
      end
    end

    context 'when initialized false in pseudo_influence' do
      let(:bool) { false }

      context 'when passed true to #pseudo_influence=' do
        it 'should have true' do
          subject.pseudo_influence = true
          expect(subject.pseudo_influence?).to \
              be_truthy
        end
      end
    end
  end
end