# encoding: utf-8

RSpec.describe Kleiber::Project do
  context 'instance methods' do
    let(:params) { {} }
    subject(:project) { build(:project, *params) }

    context '#command_with' do
      subject { project.command_with(command, args) }

      context 'up' do
        let(:command) { :up }
        let(:args) { { tasks: {}, env: {} } }
        it { is_expected.to be_an_instance_of(String) }
        it { is_expected.to satisfy { |res| p res } }

        xcontext 'with params' do
          let(:args) { { tasks: { 'setup' => 'bundle install' }, env: { 'OTHER_HOST' => '123.123.123.123' } } }
          let(:params) { [:with_tasks, :with_env] }
          it { is_expected.to satisfy { |res| p res } }
        end
      end
    end
  end
end
