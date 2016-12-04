# encoding: utf-8

RSpec.shared_context 'good config' do
  before do
    Kleiber.configure do |config|
      config.path = good_config_path
    end
  end
end

RSpec.shared_context 'bad config' do
  before do
    Kleiber.configure do |config|
      config.path = bad_config_path
    end
  end
end
