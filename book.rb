class Book
  attr_accessor :title, :author, :rentals, :id

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
    @id = Random.rand(1..1000)
  end

  def add_rentals(date, person)
    Rental.new(date, self, person)
  end

  def to_hash
    {
      title: @title,
      author: @author
    }
  end

  def serialize
    {
      'title' => title,
      'author' => author,
      'id' => id
    }
  end
end
