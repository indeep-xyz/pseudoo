RSpec.shared_examples 'creating an instance' do
  describe '.new' do
    Contextant.in(%w/all/) \
        do |object, banner|
      context banner do
        let(:source) { object }
        subject { described_class.new(source) }

        it 'should create an instance' do
          expect { subject }.not_to \
            raise_error
        end

        it 'should have the passed object' do
          expect(subject.pseudo_object).to \
              eq(source)
        end
      end
    end
  end
end