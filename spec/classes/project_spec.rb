# encoding: utf-8

include Kleiber

RSpec.describe Project do
  describe 'class methods' do
    context '#new' do
      subject { Project.new(nil) }
      it { is_expected.to be_an_instance_of(Project) }
    end

    context '#load_by_config' do
      subject { Project.load_by_config('config/path') }
      before(:each) do
        allow(Project::Config).to receive(:parse_config) { [] }
      end
      it { is_expected.to be_an_instance_of(Array) }
    end
  end
end
