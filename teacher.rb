require_relative 'person'
class Teacher < Person
  attr_reader :specializations

  def initialize(age, specialization, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def an_use_services?
    true
  end
end
