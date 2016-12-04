# encoding: utf-8

RSpec.describe Kleiber do
  context '#projects' do
    subject { Kleiber.projects }
    it { is_expected.to be_an_instance_of(Array) }
  end
end
