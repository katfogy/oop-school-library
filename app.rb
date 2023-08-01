require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'
require_relative 'inputs'
require_relative 'preserve_data'

class App
  attr_accessor :person, :books, :rentals

  def initialize
    @person = []
    @books = []
    @rentals = []
  end

  def create_book
    puts ''
    print 'Enter book title: '
    title = Input.new.user_input
    print 'Enter book author: '
    author = Input.new.user_input
    @books << Book.new(title, author)
    write_file('books.json', @books)
    puts 'Success'
  end

  def list_all_books
    puts 'All books:'
    @books = read_file('books.json')
    @books.each { |book| puts "Title: #{book['title']}, Author: #{book['author']}" }
  end

  # rubocop:disable Metrics/MethodLength
  def create_person
    puts ''
    print 'Enter 1 to add Student and 2 to add Teacher: '
    selection = Input.new.user_input_to_i
    print 'Enter name: '
    name = Input.new.user_input
    print 'Enter age: '
    age = Input.new.user_input_to_i

    case selection
    when 1
      print 'Does student have parent permission [Y/N]: '
      permission = Input.new.user_input
      student = Student.new(age, 1, permission, name)
      @person << student
    when 2
      print 'What is the teacher\'s specialization: '
      specialization = Input.new.user_input
      teacher = Teacher.new(age, specialization, name)
      @person << teacher
    end

    write_file('people.json', @person)

    print 'Success'
  end

  def list_all_people
    puts 'All People:'
    @person = read_file('people.json')
    @person.each do |person|
      puts ''
      puts(person['class'])
      puts "Name: #{person['name']}"
      puts "ID: #{person['id']}"
      puts "Age: #{person['age']}"

      if person.instance_of?(Teacher)
        puts "Specialization: #{person['specialization']}"
      else
        puts "Permission: #{person['parent_permission']}"
      end
    end
  end

  def add_rental
    puts ''
    puts 'Select a book from below by number: '
    @books = read_file('books.json')

    @books.each_with_index { |book, index| puts "#{index} - Title: #{book['title']}, Author: #{book['author']}" }
    puts ''
    book_num = Input.new.user_input_to_i
    puts ''

    puts 'Select a person from below by number: '
    @person = read_file('people.json')

    @person.each_with_index do |person, index|
      puts "#{index} - Age: #{person['age']}, Name: #{person['name']}"
    end
    puts ''
    person_num = Input.new.user_input_to_i
    puts ''

    print 'Date (yyyy/mm/dd): '
    date = Input.new.user_input

    rental = Rental.new(date, @books[book_num], @person[person_num])
    @rentals << rental
    write_file('rental.json', @rentals)
    puts ''
    puts 'Success'
  end

  # rubocop:enable Metrics/MethodLength
  def list_all_rentals
    rentals = read_file('rental.json')
    puts 'Enter the person ID to list rentals:'
    people = read_file('people.json')
    @person.clear
    people.each_with_index do |person, _index|
      puts "#{person['id']} - Name: #{person['name']}, Age: #{person['age']}"
    end
    person_id = gets.chomp.to_i
    rentals_available = rentals.select { |rental| rental['person']['id'] == person_id }
    if rentals_available.empty?
      puts "No rentals available for the person with ID #{person_id}."
    else
      puts "Listing rentals for the person with ID #{person_id}:"
      rentals_available.each do |rental|
        puts "Rental Date: #{rental['date']}"
        puts
      end
    end
  end
end

class OptionHandler
  def initialize(app)
    @app = app
  end

  def handle_option(option)
    actions = {
      1 => AddBookAction.new(@app),
      2 => ListBooksAction.new(@app),
      3 => AddPersonAction.new(@app),
      4 => ListPeopleAction.new(@app),
      5 => AddRentalAction.new(@app),
      6 => ListRentalsAction.new(@app),
      7 => ExitAction.new
    }

    action = actions[option]
    if action
      action.execute
    else
      puts 'Invalid selection'
    end
  end
end

class AddBookAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.create_book
  end
end

class ListBooksAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_all_books
  end
end

class AddPersonAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.create_person
  end
end

class ListPeopleAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_all_people
  end
end

class AddRentalAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.add_rental
  end
end

class ListRentalsAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_all_rentals
  end
end

class ExitAction
  def execute
    exit
  end
end
