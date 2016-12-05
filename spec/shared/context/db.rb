# encoding: utf-8

RSpec.shared_context 'test db' do |name = 'storage'|
  let(:storages_path) { SPEC_ROOT }
  let(:db_name) { name }
  let(:db_path) { "#{storages_path}/#{db_name}.db" }

  after(:each) do
    File.delete(db_path)
  end
end
