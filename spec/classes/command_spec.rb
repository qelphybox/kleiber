# encoding: utf-8

require 'kleiber/command'

RSpec.describe Kleiber::Command do
  subject(:command) { Kleiber::Command.new(project, vagrant_command, tasks) }
  let(:project) { Kleiber::Project.new('') }
  let(:vagrant_command) { :up }
  let(:tasks) { '' }
  it { is_expected.to be_an_instance_of(Kleiber::Command) }

  context '#compose' do
    subject { command.compose }
    it { is_expected.to eq 'vagrant up' }

    context 'with tasks' do
      before(:each) do
        allow_any_instance_of(Kleiber::Project).to receive(:task).with('setup').and_return('bundle install')
        allow_any_instance_of(Kleiber::Project).to receive(:task).with('start').and_return('bundle exec rails s')
      end
      let(:tasks) { 'setup:start' }
      it { is_expected.to eq %(vagrant up && vagrant ssh -c "cd /vagrant && bundle install && bundle exec rails s") }
    end
  end
end
