# encoding: utf-8

RSpec.describe Kleiber::Symphony do
  let(:project_names) { %w(project1 project2) }
  let(:projects) { Kleiber.projects }
  let(:tasks) { { 'setup' => 'bundle', 'run' => 'rails c' } }
  context 'class methods' do
    xcontext '#create' do
      subject { described_class.create('symphony1', project_names, tasks) }
      it { is_expected.to be_an_instance_of(described_class) }
      it { expect(subject.projects.size).to eq 2 }
    end
  end

  context 'instance methods' do
    subject(:symphony) { described_class.new('symphony1', projects, tasks) }

    context '#select_projects' do
      subject { symphony.select_projects(only) }
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
      let(:tasks_to_run) { Kleiber.settings.tasks }
      subject { symphony.task_list(tasks_to_run) }
      it { is_expected.to be_an_instance_of(Hash) }
      it { is_expected.to eq('setup' => 'bundle', 'run' => 'rails c', 'console' => 'bundle exec rails c') }
    end
  end
end
