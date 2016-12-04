# encoding: utf-8

RSpec.shared_context 'test db' do
  let(:db_path) { "#{SPEC_ROOT}/test.db" }

  after(:each) do
    File.delete(db_path)
  end
end
