# encoding: utf-8

RSpec.describe Kleiber::Symphony do
  let(:project_names) { %w(project1 project2) }
  context 'class methods' do
    xcontext '#create' do
      subject { described_class.create('symphony1', project_names, tasks) }
      it { is_expected.to be_an_instance_of(described_class) }
      it { expect(subject.projects.size).to eq 2 }
    end
  end

  context 'instance methods' do
    let(:params) { {} }
    subject(:symphony) { build(:symphony, params) }

    context '#select_projects' do
      let(:projects) { Kleiber.projects }
      subject { symphony.select_projects(only) }
      let(:params) { { projects: projects } }
      let(:only) { %w(project1) }
      it { is_expected.to be_an_instance_of(Array) }
      it 'returns only one project' do
        is_expected.to satisfy do |result|
          result.all? { |p| p.name == 'project1' }
        end
      end

      context 'empty only' do
        let(:only) { [] }
        it { is_expected.to eq projects }
      end
    end

    context '#task_list' do
      let(:params) { { tasks: { 'setup' => 'bundle', 'run' => 'rails c' } } }
      let(:tasks_to_run) { Kleiber.settings.tasks }
      subject { symphony.task_list(tasks_to_run) }
      it { is_expected.to be_an_instance_of(Hash) }
      it { is_expected.to eq('setup' => 'bundle', 'run' => 'rails c', 'console' => 'bundle exec rails c') }
    end

    context '#environment' do
      let(:params) { :project_env }
      subject { symphony.environment }
      it { is_expected.to be_an_instance_of(Hash) }
    end
  end
end
