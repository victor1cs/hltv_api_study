class Player < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :country, optional: true

  validates :nickname, presence: true, uniqueness: { case_sensitive: true }, length: { minimum: 3, maximum: 24 }
  validates :name, presence: true

  def just_name
    name.gsub(/'?#{nickname}'?/, "").squeeze(" ").strip
  end
end
