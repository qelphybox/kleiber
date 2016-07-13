# encoding: utf-8

RSpec.describe Kleiber::Project::Config::Storage do
  include FakefsSpecHelper
  context '#new' do
    subject { Kleiber::Project::Config::Storage.new(config_stub) }
    it { is_expected.to be_an_instance_of(Kleiber::Project::Config::Storage) }
    it 'has right attributes' do
      expect(subject.instance_variable_get(:@path)).to eq '/projects/proj1/.kleiber'
      expect(subject.instance_variable_get(:@config)).to be_an_instance_of(Hash)
    end
  end
end
