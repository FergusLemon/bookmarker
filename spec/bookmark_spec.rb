require 'bookmark'

describe Bookmark do
  let(:bookmark) { described_class.new }

  describe '::all_bookmarks' do
    context 'when no bookmarks have been added' do
      it 'should return a message to the user' do
        expect(described_class.all).to eq('No bookmarks have been added yet.')
      end
    end
  end
end
