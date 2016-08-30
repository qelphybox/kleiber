# encoding: utf-8

METHODS = %w(up ssh halt reload destroy provision)

RSpec.describe Kleiber::Symphony do
  context 'class methods' do
    context '#new' do
      subject { Kleiber::Symphony.new(command, args) }
      before (:each) do
        allow(Kleiber::Project).to receive(:load_by_config) { [] }
      end
      METHODS.each do |method|
        context method do
          let(:command) { method }
          let(:args) { { options: {}, config: []} }
          it { is_expected.to be_an_instance_of(Kleiber::Symphony) }
        end
      end
    end
  end
end
