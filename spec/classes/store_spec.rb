# encoding: utf-8

require 'kleiber/mixins/storagable'

RSpec.describe Kleiber::Storagable::Store do
  include_context 'test db'
  include DBSpecHelper
  context 'instance methods' do
    subject(:store) { described_class.new(db_path) }
    let(:key) { 'key' }
    let(:value) { 'value' }

    context '#write' do
      subject { store.write(key, value) }
      specify 'persists to db' do
        subject
        expect(db_read(key)).to eq(value)
      end
    end

    context '#read' do
      before { db_write(key, value) }
      subject { store.read(key) }
      it { is_expected.to eq(value) }
    end
  end
end
