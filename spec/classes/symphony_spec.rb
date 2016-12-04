# encoding: utf-8

RSpec.describe Kleiber::Symphony do
  include_context 'good config'
  context 'class methods' do
    include_context 'good config'
    context '#create' do
      subject { described_class.create('symphony1', project_names) }
      let(:project_names) { %w(project1 project2) }
      it { is_expected.to be_an_instance_of(described_class) }
      it { expect(subject.projects.size).to eq 2 }
    end
  end
end
