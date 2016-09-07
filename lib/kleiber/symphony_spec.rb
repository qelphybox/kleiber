# encoding: utf-8

include Kleiber

RSpec.describe Symphony do
  before(:each) do
    allow(Project).to receive(:load_by_config) {  }
  end
  describe 'class methods' do
    context '#new' do
      it { is_expected.to be_an_instance_of(Symphony) }
    end
  end
end
