require_relative '../person'

describe 'Person' do
  prs = Person.new(17, true, 'John Doe')
  it 'should return the correct name' do
    expect(prs.correct_name).to eq('John Doe')
  end
  it 'should return the correct age' do
    expect(prs.age).to eq(17)
  end
  describe '#serialize' do
    it 'should return the correct hash' do
      expect(prs.serialize).to eq({
                                    'name' => 'John Doe',
                                    'age' => 17,
                                    'id' => prs.id
                                  })
    end
  end
end