# encoding: utf-8

RSpec.shared_context 'test db' do |name = 'store'|
  let(:stores_path) { SPEC_ROOT }
  before { stub_const('Kleiber::Storagable::STORES_PATH', stores_path) }
  let(:db_name) { name }
  let(:db_path) { "#{stores_path}/#{db_name}.db" }

  after(:each) do
    File.delete(db_path)
  end
end
