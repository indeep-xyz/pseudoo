RSpec.shared_examples \
    'in BasicObject, own instance methods' do
  describe '#pseudo?' do
    subject { described_class.new }

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

  describe '#pseudoo_infection?' do
    subject { described_class.new(infection: bool) }

    context 'when initialized no option for @pseudoo_infection' do
      subject { described_class.new }

      it 'should return true' do
        expect(subject.pseudoo_infection?).to \
            be_truthy
      end
    end

    context 'when initialized @pseudoo_infection to true' do
      let(:bool) { true }

      it 'should return true' do
        expect(subject.pseudoo_infection?).to \
            be_truthy
      end
    end

    context 'when initialized @pseudoo_infection to false' do
      let(:bool) { false }

      it 'should return false' do
        expect(subject.pseudoo_infection?).to \
            be_falsey
      end
    end
  end

  describe '#pseudoo_infection=' do
    subject { described_class.new(infection: bool) }

    context 'when initialized @pseudoo_infection to true' do
      let(:bool) { true }

      context 'when passed false to #pseudoo_infection=' do
        it 'should have false' do
          subject.pseudoo_infection = false
          expect(subject.pseudoo_infection?).to \
              be_falsey
        end
      end
    end

    context 'when initialized false in pseudoo_infection' do
      let(:bool) { false }

      context 'when passed true to #pseudoo_infection=' do
        it 'should have true' do
          subject.pseudoo_infection = true
          expect(subject.pseudoo_infection?).to \
              be_truthy
        end
      end
    end
  end
end