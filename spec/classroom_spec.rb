require_relative '../classroom'

describe Classroom do
  before :each do
    @classroom = Classroom.new('C1')
  end
  it 'should add a student to the classroom' do
    student = double('student')
    allow(student).to receive(:classroom=)
    @classroom.add_student(student)
    expect(@classroom.students).to include(student)
  end
end