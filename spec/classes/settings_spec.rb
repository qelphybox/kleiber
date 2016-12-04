# encoding: utf-8

RSpec.describe Kleiber::Settings do
  context 'instance methods' do
    subject(:settings) { Kleiber::Settings.new(path) }
    context '#valid?' do
      subject { settings.valid? }
      context 'good config' do
        let(:path) { good_config_path }
        it { is_expected.to eq true }
      end

      context 'bad config' do
        let(:path) { bad_config_path }
        it { expect { subject }.to raise_error(RuntimeError, 'Wrong config') }
      end
    end
  end
end
