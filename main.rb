require_relative 'app'
require_relative 'inputs'

def list_options
  '
      1 - Add a book
      2 - Show all books
      3 - Add a person
      4 - Show all people
      5 - Add a rental
      6 - Show all rentals for a given ID
      7 - Exit
    '
end

def main
  app = App.new
  option_handler = OptionHandler.new(app)
  puts "Welcome to the School Library App!\n\n"

  loop do
    puts list_options
    option = Inputs.user_input_to_i
    option_handler.handle_option(option)
  end
end

main
