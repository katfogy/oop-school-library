require_relative '../teacher'

describe Teacher do
  describe '#initialize' do
    it 'Creates a new teacher' do
      teacher = Teacher.new(34, 'Math', 'John Doe')
      expect(teacher).to be_an_instance_of Teacher
    end
  end

  describe '#can_use_services' do
    it 'Returns true' do
      teacher = Teacher.new(34, 'Math', 'John Doe')
      expect(teacher.can_use_services).to eq(true)
    end
  end
end