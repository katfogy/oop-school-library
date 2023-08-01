require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
require_relative 'inputs'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_all_books
    puts 'LIST OF ALL AVAILABLE BOOKS:'
    if @books.empty?
      puts 'No books available'
    else
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_all_people
    puts 'LIST OF PEOPLE:'
    if @people.empty?
      puts 'No person available'
    else
      @people.each do |person|
        puts " [#{person.class}] Name:#{person.name}, Age:#{person.age}, ID:#{person.id}"
      end
    end
  end

  def create_person
    print 'Do you want to create a Student (1) or a Teacher (2)? [Input the number]:'
    choice = Inputs.user_input_to_i

    if choice == 1
      create_student
    elsif choice == 2
      create_teacher
    else
      puts 'Invalid choice. Please choose 1 for Student or 2 for Teacher.'
    end
  end

  def create_student
    print 'Name: '
    name = Inputs.user_input

    print 'Age: '
    age = Inputs.user_input_to_i

    print 'Has parent permission [Y/N]: '
    parent_permission = Inputs.user_input

    if parent_permission.downcase == 'n'
      student = Student.new('classroom', name, true, age)
    elsif parent_permission.downcase == 'y'
      student = Student.new('classroom', name, false, age)
    else
      puts 'Invalid Selection'
      return
    end
    @people << student
    puts 'Student Created Successfully'
  end

  def create_teacher
    print 'Name: '
    name = Inputs.user_input

    print 'Age: '
    age = Inputs.user_input_to_i

    print 'Specialization: '
    specialization = Inputs.user_input
    teacher = Teacher.new(specialization, name, true, age)
    @people << teacher
    puts 'Teacher Created Successfully'
  end

  def create_book
    print 'Title: '
    title = Inputs.user_input

    print 'Author: '
    author = Inputs.user_input

    book = Book.new(title, author)
    @books << book
    puts 'Book Created Successfully'
  end

  def create_rental
    puts 'Select a book from the following lists'
    @books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_index = Inputs.user_input_to_i

    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) Name: #{person.name}, AGE: #{person.age}, ID: #{person.id}"
    end
    person_index = Inputs.user_input_to_i

    print 'Date: '
    date_of_rental = Inputs.user_input

    rental = Rental.new(date_of_rental, @books[book_index], @people[person_index])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_rentals
    print "\nID of the person: "
    person_id = Inputs.user_input_to_i

    found_rentals = @rentals.select { |rental| rental.person.id == person_id }

    if found_rentals.empty?
      puts "There are currently no rented books in the system under #{person_id} id."
    else
      puts 'Rentals:'
      found_rentals.each do |rental|
        puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
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
    @app.create_rental
  end
end

class ListRentalsAction
  def initialize(app)
    @app = app
  end

  def execute
    @app.list_rentals
  end
end

class ExitAction
  def execute
    exit
  end
end
