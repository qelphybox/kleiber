# encoding: utf-8

RSpec.describe Kleiber::Performer do
  context 'instance methods' do
    subject(:performer) { build(:performer) }

    context '#task_names' do
      subject { performer.task_names }
      it { is_expected.to be_an_instance_of(Array) }
    end

    context '#tasks' do
      subject { performer.tasks }
      it { is_expected.to be_an_instance_of(Hash) }
    end
  end
end
