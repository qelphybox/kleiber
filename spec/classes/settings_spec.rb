# encoding: utf-8

RSpec.describe Kleiber::Settings do
  context 'instance methods' do
    subject(:settings) { Kleiber::Settings.new(path) }
    let(:path) { good_config_path }
    context '#valid?' do
      subject { settings.valid? }
      context 'good config' do
        it { is_expected.to eq true }
      end

      context 'bad config' do
        let(:path) { bad_config_path }
        it { is_expected.to eq false }
      end
    end

    context '#projects' do
      subject { settings.projects }
      it { is_expected.to be_an_instance_of(Array) }
    end

    context '#tasks' do
      subject { settings.tasks }
      it { is_expected.to be_an_instance_of(Hash) }
    end

    context '#terminal' do
      subject { settings.terminal }
      it { is_expected.to be_an_instance_of(Hash) }
    end

    context '#symphonies' do
      subject { settings.symphonies }
      it { is_expected.to be_an_instance_of(Hash) }
    end
  end
end
