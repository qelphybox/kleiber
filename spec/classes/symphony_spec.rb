# encoding: utf-8

include Kleiber

RSpec.describe Symphony do
  include SymphonySpecHelper
  describe 'class methods' do
    context '#new' do
      subject { Symphony.new(:up, args) }
      let!(:projects) { projects_stub }
      before(:each) do
        allow(Project).to receive(:load_by_config) { [] }
      end
      context 'with right params' do
        let(:args) { { options: {}, projects: projects } }
        it { is_expected.to be_an_instance_of(Symphony) }
        it { is_expected.to have_attributes(command: :up,
                                            tasks: nil,
                                            projects: []) }
      end
    end
  end
end
