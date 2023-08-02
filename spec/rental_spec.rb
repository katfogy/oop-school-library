require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe Rental do
  describe '#initialize' do
    it 'creates a new instance of Rental' do
      person = Person.new(22, true, 'John Doe')
      book = Book.new('Book Title', 'Book Author')
      rental = Rental.new('2021-06-01', book, person)
      expect(rental).to be_a(Rental)
    end
  end

  describe '#serialize' do
    it 'returns a hash with the rental data' do
      person = Person.new(32, true, 'David')
      book = Book.new('Book Title', 'Book Author')
      rental = Rental.new('2021-06-01', book, person)
      expect(rental.serialize).to eql('date' => '2021-06-01', 'book_id' => book.id, 'person_id' => person.id)
    end
  end
  describe '#to_hash' do
    it 'returns a hash with the rental data' do
      person = Person.new(27, true, 'Abdul')
      book = Book.new('Book Title', 'Book Author')
      rental = Rental.new('2021-06-01', book, person)
      expected_hash = {
        date: '2021-06-01',
        book: book,
        person: person
      }
      expect(rental.to_hash).to eql(expected_hash)
    end
  end
end
