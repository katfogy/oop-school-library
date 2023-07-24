require_relative 'student'
require_relative 'teacher'

student = Student.new(14, 'JSS 1A', 'Foga', false)
puts student.play_hooky
puts student.can_use_services?

teacher = Teacher.new(23, 'Physics', 'Amos', false)
puts teacher.inspect
puts teacher.can_use_services?