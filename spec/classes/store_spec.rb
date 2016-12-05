# encoding: utf-8

require 'kleiber/mixins/storagable'

RSpec.describe Kleiber::Storagable::Storage do
  include_context 'test db'
  include DBSpecHelper
  context 'instance methods' do
    subject(:storage) { described_class.new(db_path) }
    let(:key) { 'key' }
    let(:value) { 'value' }

    context '#write' do
      subject { storage.write(key, value) }
      specify 'persists to db' do
        subject
        expect(db_read(key)).to eq(value)
      end
    end

    context '#read' do
      before { db_write(key, value) }
      subject { storage.read(key) }
      it { is_expected.to eq(value) }
    end
  end
end
