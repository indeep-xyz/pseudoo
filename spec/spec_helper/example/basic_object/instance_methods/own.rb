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
end