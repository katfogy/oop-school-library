require_relative 'nameable'
require_relative 'capitalize_decorator'
require_relative 'base_decorator'
require_relative 'trimmer_decorator'

class Person < Nameable
  # getters
  attr_reader :parent_permission
  attr_accessor :id, :age, :name, :rentals

  # constructor
  def initialize(age, parent_permission, name = 'Unknown')
    super()
    # instance variables
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  # public methods

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def add_rentals(book, date)
    Rental.new(date, book, self)
  end

  def to_hash
    {
      id: @id,
      name: @name,
      age: @age,
      parent_permission: @parent_permission
    }
  end

  def serialize
    {
      'name' => name,
      'age' => age,
      'id' => id
    }
  end

  # private method

  private

  def of_age?
    @age >= 18
  end
end
