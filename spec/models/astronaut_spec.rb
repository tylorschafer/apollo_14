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

  describe 'Instance methods' do
    it "time_in_space calculates total time in space per astronaut" do
      bob = Astronaut.create!(name: 'Bob', age: 45, job: 'Pilot')
      moe = Astronaut.create!(name: 'Moe', age: 33, job: 'Engineer')
      joe = Astronaut.create!(name: 'Joe', age: 36, job: 'Physicist')

      capricorn = bob.missions.create(title: 'Capricorn 4', time_in_space: 80)
      apollo = bob.missions.create(title: 'Apollo 13', time_in_space: 100)
      gemini = moe.missions.create(title: 'Gemini 7', time_in_space: 120)
      moe.missions << capricorn
      joe.missions << apollo
      joe.missions << gemini

      expect(bob.total_time_in_space).to eq(180)
      expect(moe.total_time_in_space).to eq(200)
      expect(joe.total_time_in_space).to eq(220)
    end
  end
end
