require_relative '../student'

describe 'Student' do
  describe '#initialize' do
    it 'creates a new student' do
      student = Student.new(15, 'C2', false, 'John Doe')
      expect(student).to be_a(Student)
    end
  end

  describe '#play_hooky' do
    it 'returns a string' do
      student = Student.new(15, 'C2', false, 'John Doe')
      expect(student.play_hooky).to be_a(String)
    end
  end
end
