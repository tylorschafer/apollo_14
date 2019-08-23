require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe 'Class methods' do
    it "average age can calculate the average age of all astronaughts" do
      bob = Astronaut.create!(name: 'Bob', age: 45, job: 'Pilot')
      moe = Astronaut.create!(name: 'Moe', age: 33, job: 'Engineer')
      joe = Astronaut.create!(name: 'Joe', age: 36, job: 'Physicist')

      expect(Astronaut.average_age).to eq(38)
    end
  end
end
