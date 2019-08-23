class Astronaut < ApplicationRecord
  has_many :astronaut_missions
  has_many :missions, through: :astronaut_missions
  validates_presence_of :name, :age, :job

  def self.average_age
    Astronaut.average(:age)
  end

  def mission_list
    missions.order(:title).pluck(:title)
  end

  def total_time_in_space
    missions.sum(:time_in_space)
  end
end
