# encoding: utf-8

RSpec.describe Kleiber do
  include_context 'good config'
  context '#projects' do
    subject { Kleiber.projects }
    it { is_expected.to be_an_instance_of(Array) }
    it 'is array of projects' do
      is_expected.to satisfy do |result|
        result.all? { |p| p.is_a?(Kleiber::Project) }
      end
    end
  end

  context '#configure' do
    specify { expect { |b| Kleiber.configure(&b) }.to yield_with_args(an_instance_of(Kleiber::Settings)) }
  end

  context '#settings' do
    subject { Kleiber.settings }
    it { is_expected.to be_an_instance_of(Kleiber::Settings) }
  end

  context '#terminal' do
    subject { Kleiber.terminal }
    it { is_expected.to be_an_instance_of(Kleiber::Terminal) }
  end

  context '#symphonies' do
    subject { Kleiber.symphonies }
    it { is_expected.to be_an_instance_of(Hash) }
  end

  context '#perform' do
    let(:symphony_name) { 'symphony1' }
    let(:projects_only) { [] }
    let(:options) { {} }
    subject { Kleiber.perform(symphony_name, projects_only, options) }
    it { is_expected.to be_an_instance_of(Kleiber::Performer) }
  end
end
