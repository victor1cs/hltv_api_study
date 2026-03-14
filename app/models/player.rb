class Player < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :country, optional: true

  def just_name
    name.gsub(/'?#{nickname}'?/, "").squeeze(" ").strip
  end
end
