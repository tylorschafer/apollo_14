require 'rails_helper'

describe 'astronauts index page' do
  before :each do
    @bob = Astronaut.create!(name: 'Bob', age: 45, job: 'Pilot')
    @moe = Astronaut.create!(name: 'Moe', age: 33, job: 'Engineer')
    @joe = Astronaut.create!(name: 'Joe', age: 36, job: 'Physicist')
    @all = [@bob,@moe,@joe]
  end
  it "I see a list of astronauts and their info" do
    visit '/astronauts'

    @all.each do |naut|
      within "#naut-#{naut.id}" do
        expect(page).to have_content(naut.name)
        expect(page).to have_content(naut.age)
        expect(page).to have_content(naut.job)
      end
    end
  end
end
