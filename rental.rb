class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
  end

  def to_hash
    {
      date: @date,
      book: @book,
      person: @person
    }
  end

  def serialize
    {
      'date' => date,
      'person_id' => person.id,
      'book_id' => book.id
    }
  end
end
