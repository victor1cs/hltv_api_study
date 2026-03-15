class Team < ApplicationRecord
  has_many :players

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 4, maximum: 16 }
end
