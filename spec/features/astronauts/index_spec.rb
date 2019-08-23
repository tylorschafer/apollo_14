require 'rails_helper'

describe 'astronauts index page' do
  before :each do
    @bob = Astronaut.create!(name: 'Bob', age: 45, job: 'Pilot')
    @moe = Astronaut.create!(name: 'Moe', age: 33, job: 'Engineer')
    @joe = Astronaut.create!(name: 'Joe', age: 36, job: 'Physicist')
    @all = [@bob,@moe,@joe]

    @capricorn = @bob.missions.create(title: 'Capricorn 4', time_in_space: 80)
    @apollo = @bob.missions.create(title: 'Apollo 13', time_in_space: 100)
    @gemini = @moe.missions.create(title: 'Gemini 7', time_in_space: 120)
    @moe.missions << @capricorn
    @joe.missions << @apollo
    @joe.missions << @gemini
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

  it "I can see the average age of all astronauts" do
    visit '/astronauts'

    expect(page).to have_content("Average Age: 38")
  end

  it "I see a list of space missions in alphabetical order for each astronaut." do
    visit '/astronauts'

    within "#naut-#{@bob.id}" do
      expect(page).to have_content("Missions:\nApollo 13\nCapricorn 4")
    end

    within "#naut-#{@moe.id}" do
      expect(page).to have_content("Missions:\nCapricorn 4\nGemini 7")
    end

    within "#naut-#{@joe.id}" do
      expect(page).to have_content("Missions:\nApollo 13\nGemini 7")
    end
  end

  it "I can see the total time in space spent for each astronaut" do
    visit '/astronauts'

    within "#naut-#{@bob.id}" do
      expect(page).to have_content("Total Time in Space: 180 days")
    end

    within "#naut-#{@moe.id}" do
      expect(page).to have_content("Total Time in Space: 200 days")
    end

    within "#naut-#{@joe.id}" do
      expect(page).to have_content("Total Time in Space: 220 days")
    end
  end
end
