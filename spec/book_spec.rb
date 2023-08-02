require_relative '../book'

describe Book do
  let(:book) { Book.new('The Lord of the Rings', 'J. R. R. Tolkien') }

  describe '#initialize' do
    it 'creates a new book' do
      expect(book).to be_a(Book)
    end
  end

  describe '#add_rental' do
    it 'adds a rental to the book' do
      expect(book.rentals).to eq([])
    end
  end

  describe '#serialize' do
    it 'serializes a book' do
      expect(book.serialize).to eq(
        {
          'title' => 'The Lord of the Rings',
          'author' => 'J. R. R. Tolkien',
          'id' => book.id
        }
      )
    end
  end
end
